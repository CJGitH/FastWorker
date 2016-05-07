//
//  UIView+Frame.h
//  百思不得姐1.1
//
//  Created by chen on 16/4/2.
//  Copyright © 2016年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property CGFloat cj_width;
@property CGFloat cj_height;
@property CGFloat cj_x;
@property CGFloat cj_y;
@property CGFloat cj_centerY;
@property CGFloat cj_centerX;

//加载xib
+ (instancetype)CJ_ViewFromxib;
@end
