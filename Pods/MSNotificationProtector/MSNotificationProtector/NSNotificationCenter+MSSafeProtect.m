//
//  NSNotificationCenter+MSSafeProtect.m
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import "NSNotificationCenter+MSSafeProtect.h"
#import "NSObject+MSSwizzle.h"
#import <pthread.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import "MSMonitorObject.h"

static BOOL MSNotificationCenterProtectEnable = YES;
static pthread_mutex_t lock;//结构体
@implementation NSNotificationCenter (MSSafeProtect)

+ (void)load{
    
    //iOS 9开始系统会自动为我们移除通知   但是 7 8 都会立即崩溃 所以只交换9以下
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_9_0) {
        
        [self swizzleInstanceSelector:@selector(addObserver:selector:name:object:) withNewSelector:@selector(msAddObserver:selector:name:object:)];
        
        [self swizzleInstanceSelector:@selector(addObserverForName:object:queue:usingBlock:) withNewSelector:@selector(msAddObserverForName:object:queue:usingBlock:)];
        pthread_mutex_init(&lock, NULL);
    }
}

- (void)msAddObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject{
    
    [self msAddObserver:observer selector:aSelector name:aName object:anObject];
    [self handleObserver:observer];
}

- (id<NSObject>)msAddObserverForName:(NSNotificationName)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification * _Nonnull))block{
    id <NSObject> observer = [self msAddObserverForName:name object:obj queue:queue usingBlock:block];
    [self handleObserver:observer];
    return observer;
}

- (void)handleObserver:(id)observer{
    
    if (MSNotificationCenterProtectEnable && observer){
        
        pthread_mutex_lock(&lock);
        MSMonitorObject *monitor = objc_getAssociatedObject(observer, MSNotificationCenterMonitorObjectKey);
        if (!monitor) {//如果observer 没有这个 附加帮助移除对象
            monitor = [MSMonitorObject new];
            monitor.target = observer;//设置 为 observer
            monitor.deallocBlock = [^(id <NSObject> obj){//创建block
                if (obj) {//虽然此处 obj已经dealloc完毕了 但是 并没有向obj发送消息 所以并不会也指针访问
                    [self removeObserver:obj];//observer dealloc的时候 会调用 monitor的dealloc 执行此block
                }
            } copy];
            objc_setAssociatedObject(observer, MSNotificationCenterMonitorObjectKey, monitor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        pthread_mutex_unlock(&lock);
    }
}


+ (void)msSetProtectEnable:(BOOL)en{
    MSNotificationCenterProtectEnable = en;
}

@end
