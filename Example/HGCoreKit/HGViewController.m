//
//  HGViewController.m
//  HGCoreKit
//
//  Created by harleyGit on 01/17/2024.
//  Copyright (c) 2024 harleyGit. All rights reserved.
//

#import "HGViewController.h"

#import <LogUtil.h>

@interface HGViewController ()

@end

@implementation HGViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	
    [LogUtil debugLog:@"测试打印类"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
