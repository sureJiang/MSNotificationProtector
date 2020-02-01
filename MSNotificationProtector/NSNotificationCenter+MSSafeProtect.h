//
//  NSNotificationCenter+MSSafeProtect.h
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (MSSafeProtect)
+ (void)msSetProtectEnable:(BOOL)en;

@end
