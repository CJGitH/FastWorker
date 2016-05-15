//
//  CJCodeViewController.m
//  FastWorker
//
//  Created by chen on 16/5/12.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJCodeViewController.h"

#import "XMGQRCodeTool.h"



@interface CJCodeViewController ()

@property (weak, nonatomic) IBOutlet UIView *scanBackView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBottom;


@end

@implementation CJCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    self.view.backgroundColor = [UIColor redColor];
    [self beginScanAnimation];
    [self beginScan];
    
}

//返回上一层
- (IBAction)back:(id)sender {
 
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 开始扫描
- (void)beginScan
{
    
    [XMGQRCodeTool sharedXMGQRCodeTool].isDrawQRCodeRect = YES;
    [[XMGQRCodeTool sharedXMGQRCodeTool] setInsteretRect:self.scanBackView.frame];
    [[XMGQRCodeTool sharedXMGQRCodeTool] beginScanInView:self.view result:^(NSArray<NSString *> *resultStrs) {

        [[XMGQRCodeTool sharedXMGQRCodeTool] stopScan];
        
    }];
    
    
    
}



// 开始扫描动画
- (void)beginScanAnimation
{
    self.toBottom.constant = self.scanBackView.frame.size.height;
    [self.view layoutIfNeeded];
    
    
    [UIView animateWithDuration:2 animations:^{
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
        self.toBottom.constant = - self.scanBackView.frame.size.height;
        [self.view layoutIfNeeded];
        
    }];
    
    
}




@end
