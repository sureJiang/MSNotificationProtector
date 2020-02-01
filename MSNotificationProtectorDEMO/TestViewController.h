//
//  TestViewController.h
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString  * const testNotification = @"testNotification";

typedef void (^TestVCDeallocBlock)(id <NSObject> obj);

@interface TestViewController : UIViewController

@property (nonatomic, copy)   TestVCDeallocBlock deallocBlock;

@end
