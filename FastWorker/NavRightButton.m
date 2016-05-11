//
//  NavRightButton.m
//  FastWorker
//
//  Created by chen on 16/5/6.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "NavRightButton.h"

@implementation NavRightButton


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45, self.frame.size.height * 0.8, 30, 30);
    
}

@end
