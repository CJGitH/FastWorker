//
//  CJTopBtn.m
//  FastWorker
//
//  Created by chen on 16/5/9.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJTopBtn.h"

@implementation CJTopBtn


- (void)layoutSubviews {

    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, 100, 100);
    self.titleLabel.frame = CGRectMake(0, 100, 100, 30);
    
}

@end
