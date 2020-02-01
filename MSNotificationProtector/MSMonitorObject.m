//
//  MSMonitorObject.m
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import "MSMonitorObject.h"

@implementation MSMonitorObject

- (void)dealloc{
    id <NSObject> target = self.target;
    if (self.deallocBlock && target) {
        self.deallocBlock(target);
    }
}
@end
