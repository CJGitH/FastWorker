//
//  CJNavigationController.m
//  FastWorker
//
//  Created by chen on 16/5/6.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJNavigationController.h"
//#import "CJTabBarController.h"


@interface CJNavigationController ()

@end

@implementation CJNavigationController



+ (void)load
{
    // 获取当前类下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    [UINavigationBar appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    navBar.titleTextAttributes = attr;
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"bubble_rectangle_6"] forBarMetrics:UIBarMetricsDefault];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}


@end
