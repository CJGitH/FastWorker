//
//  NavButton.m
//  FastWorker
//
//  Created by chen on 16/5/6.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "NavButton.h"

@implementation NavButton

- (void)layoutSubviews {

    [super layoutSubviews];
    self.frame = CGRectMake(0, self.frame.size.height * 0.5, 30, 30);
    
}

@end
