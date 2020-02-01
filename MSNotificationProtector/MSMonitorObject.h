//
//  MSMonitorObject.h
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MSDeallocMonitorBlock)(id <NSObject> obj);
static void *MSNotificationCenterMonitorObjectKey = &MSNotificationCenterMonitorObjectKey;

@interface MSMonitorObject:NSObject
@property (nonatomic, copy)   MSDeallocMonitorBlock deallocBlock;
@property (nonatomic, assign) id <NSObject>         target;
@end
