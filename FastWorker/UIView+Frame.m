//
//  UIView+Frame.m
//  百思不得姐1.1
//
//  Created by chen on 16/4/2.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

//从xib中加载xib
+ (instancetype)CJ_ViewFromxib
{

    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


- (CGFloat)cj_centerX
{
    return self.center.x;
}
- (void)setCj_centerX:(CGFloat)cj_centerX
{
    CGPoint center = self.center;
    center.x = cj_centerX;
    self.center = center;
}

- (CGFloat)cj_centerY
{
    return self.center.y;
}
- (void)setCj_centerY:(CGFloat)cj_centerY
{
    CGPoint center = self.center;
    center.y = cj_centerY;
    self.center = center;
}

- (CGFloat)cj_height
{
    return self.frame.size.height;
}

- (void)setCj_height:(CGFloat)cj_height
{
    CGRect rect = self.frame;
    rect.size.height = cj_height;
    self.frame = rect;
}

- (CGFloat)cj_width
{
    return self.frame.size.width;
}

- (void)setCj_width:(CGFloat)cj_width
{
    CGRect rect = self.frame;
    rect.size.width = cj_width;
    self.frame = rect;
    
}

- (CGFloat)cj_x
{
    return self.frame.origin.x;
}

- (void)setCj_x:(CGFloat)cj_x
{
    CGRect rect = self.frame;
    rect.origin.x = cj_x;
    self.frame = rect;
    
}

- (CGFloat)cj_y
{
    return self.frame.origin.y;
}
- (void)setCj_y:(CGFloat)cj_y
{
    CGRect rect = self.frame;
    rect.origin.y = cj_y;
    self.frame = rect;
    
}
@end
