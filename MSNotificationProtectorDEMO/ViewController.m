//
//  ViewController.m
//  MSNotificationProtector
//
//  Created by JZJ on 2016/9/16.
//  Copyright © 2016年 JZJ. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TestViewController * vc = [TestViewController new];
    [vc setDeallocBlock:^(id<NSObject> obj) {
    [[NSNotificationCenter defaultCenter] postNotificationName:testNotification                                       object:nil];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
