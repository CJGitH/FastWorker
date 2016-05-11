//
//  CJTableViewController.m
//  FastWorker
//
//  Created by chen on 16/5/10.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJTableViewController.h"

@interface CJTableViewController ()

@end

@implementation CJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -- 返回上一层
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
