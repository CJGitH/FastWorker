//
//  CJThreeBtn.m
//  FastWorker
//
//  Created by chen on 16/5/9.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJThreeBtn.h"

@implementation CJThreeBtn

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat btnW = self.bounds.size.width;
    
    
    self.imageView.frame = CGRectMake(25, 15, 35, 35);
    self.titleLabel.frame = CGRectMake(0, 50, btnW, 30);
    
}

@end
