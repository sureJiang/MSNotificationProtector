//
//  NSObject+MSSwizzle.h
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MSSwizzle)

+ (void)swizzleInstanceSelector:(SEL)originalSelector
                withNewSelector:(SEL)newSelector;

+ (void) swizzleClassSelector:(SEL)originalSelector
              withNewSelector:(SEL)newSelector;

@end
