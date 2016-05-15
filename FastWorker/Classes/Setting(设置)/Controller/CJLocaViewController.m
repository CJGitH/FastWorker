//
//  CJLocaViewController.m
//  FastWorker
//
//  Created by chen on 16/5/11.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJLocaViewController.h"

@interface CJLocaViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;


@end

@implementation CJLocaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回按钮
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//选择按钮
- (IBAction)choseBtn:(id)sender {
    
    
    
    self.bottomLine.constant = self.bottomLine.constant == 0 ? -45 : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
