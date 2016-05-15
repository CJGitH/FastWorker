//
//  CJSettingViewController.m
//  FastWorker
//
//  Created by chen on 16/5/8.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJSettingViewController.h"
#import "CJTopBtn.h"
#import "CJOneBtn.h"
#import "CJTwoBtn.h"
#import "CJThreeBtn.h"
#import "CJshouYeBtn.h"
#import "JCfindBtn.h"
#import "CJsetBtn.h"
#import "CJlocinBtn.h"

#import "CJLocaViewController.h"


#import "CJTableViewController.h"



@interface CJSettingViewController ()

@property(nonatomic, strong)CJshouYeBtn * shouYeBtn;
@property(nonatomic, strong)JCfindBtn* findBtn;
@property(nonatomic, strong)CJsetBtn* setBtn;
@property(nonatomic, strong)CJlocinBtn* locinBtn;
@end

@implementation CJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Snip20160509_4"]];


    //设置顶部的头标
    [self setupTopViewIcon];
    
    //默认点击第一个
    [self shouYeBtnClick:self.shouYeBtn];
    

    
}

- (void)setupTopViewIcon {
 
    //放图标和三个按钮的view
    UIView * iconView = [[UIView alloc]init];
    iconView.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.7, 250);
//    iconView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:iconView];
    
    //添加图标
    CJTopBtn * topBtn = [[CJTopBtn alloc]init];
    [topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topBtn setImage:[UIImage imageNamed:@"detail_avatar_famale"] forState:UIControlStateNormal];
    [topBtn setTitle:@"surprise" forState:UIControlStateNormal];
    topBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    topBtn.frame = CGRectMake(80, 30, 100, 130);
    [iconView addSubview:topBtn];
    
    //添加底部的三个按钮
    CGFloat btnW = self.view.bounds.size.width * 0.7 / 3;
    CGFloat btnH = 80;
    CJOneBtn * oneBtn = [[CJOneBtn alloc]init];
    [oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [oneBtn setImage:[UIImage imageNamed:@"edit_btn_font_selected"] forState:UIControlStateNormal];
    [oneBtn setTitle:@"八卦" forState:UIControlStateNormal];
    oneBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    oneBtn.backgroundColor = [UIColor redColor];
    CGFloat btnY = iconView.bounds.size.height - btnH;
    oneBtn.frame = CGRectMake(0, btnY, btnW, btnH);
    [iconView addSubview:oneBtn];
    
    CJTwoBtn * twoBtn = [[CJTwoBtn alloc]init];
    [twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [twoBtn setImage:[UIImage imageNamed:@"edit_btn_filter_selected"] forState:UIControlStateNormal];
    [twoBtn setTitle:@"消息" forState:UIControlStateNormal];
    twoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        twoBtn.backgroundColor = [UIColor greenColor];
    twoBtn.frame = CGRectMake(btnW, btnY, btnW, btnH);
    [iconView addSubview:twoBtn];
    
    CJThreeBtn * threeBtn = [[CJThreeBtn alloc]init];
    [threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [threeBtn setImage:[UIImage imageNamed:@"edit_btn_frame_selected"] forState:UIControlStateNormal];
    [threeBtn setTitle:@"私信" forState:UIControlStateNormal];
    threeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        threeBtn.backgroundColor = [UIColor orangeColor];
    threeBtn.frame = CGRectMake(btnW * 2, btnY, btnW, btnH);
    [iconView addSubview:threeBtn];
    
    
    //首页
    
    CGFloat anlbtnX = 0;
    CGFloat anlbtnY = iconView.frame.size.height;
    CGFloat anlbtnW = self.view.bounds.size.width * 0.7;
    CGFloat anlbtnH = 60;
    CJshouYeBtn * shouYeBtn = [[CJshouYeBtn alloc]init];
    self.shouYeBtn = shouYeBtn;
    [shouYeBtn addTarget:self action:@selector(shouYeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shouYeBtn setImage:[UIImage imageNamed:@"edit_btn_font_selected"] forState:UIControlStateNormal];
    [shouYeBtn setTitle:@"首页" forState:UIControlStateNormal];
    shouYeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    shouYeBtn.frame = CGRectMake(anlbtnX, anlbtnY, anlbtnW, anlbtnH);
//    shouYeBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:shouYeBtn];
    
    //查找
     JCfindBtn* findBtn = [[JCfindBtn alloc]init];
    self.findBtn = findBtn;
    [findBtn addTarget:self action:@selector(findBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [findBtn setImage:[UIImage imageNamed:@"edit_btn_nomusic_selected"] forState:UIControlStateNormal];
    [findBtn setTitle:@"查找" forState:UIControlStateNormal];
    findBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    findBtn.frame = CGRectMake(anlbtnX, anlbtnY + anlbtnH, anlbtnW, anlbtnH);
//    findBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:findBtn];
    
    //设置
    CJsetBtn* setBtn = [[CJsetBtn alloc]init];
    self.setBtn = setBtn;
    [setBtn addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setImage:[UIImage imageNamed:@"edit_btn_more_pressed"] forState:UIControlStateNormal];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    setBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    setBtn.frame = CGRectMake(anlbtnX, anlbtnY + (2 * anlbtnH), anlbtnW, anlbtnH);
//    setBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:setBtn];
    
    //本业作品集
    CJlocinBtn* locinBtn = [[CJlocinBtn alloc]init];
    self.locinBtn = locinBtn;
    [locinBtn addTarget:self action:@selector(locinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [locinBtn setImage:[UIImage imageNamed:@"edit_btn_sticker_selected"] forState:UIControlStateNormal];
    [locinBtn setTitle:@"本地作品集" forState:UIControlStateNormal];
    locinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    locinBtn.frame = CGRectMake(anlbtnX, anlbtnY + (3 * anlbtnH), anlbtnW, anlbtnH);
//    locinBtn.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:locinBtn];
    
    
}

#pragma mark -- 点击头标按钮时调用
- (void)topBtnClick {

    NSLog(@"点击了头标");
}
//八卦
- (void)oneBtnClick {
    NSLog(@"八卦");
}
//消息
- (void)twoBtnClick {
    NSLog(@"消息");
}
//私信
- (void)threeBtnClick {

    NSLog(@"私信");
}
//首页
- (void)shouYeBtnClick:(UIButton *)button {

    self.findBtn.backgroundColor = [UIColor clearColor];
    self.setBtn.backgroundColor = [UIColor clearColor];
    self.locinBtn.backgroundColor = [UIColor clearColor];
    
    button.backgroundColor = [UIColor colorWithRed:200.0 / 250 green:160.0 / 250 blue:130.0 / 250 alpha:0.7];
    NSLog(@"首页");
    
    
//    self.view.frame = CGRectMake(- self.view.bounds.size.width * 0.7, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}
//查找
- (void)findBtnClick:(UIButton *)button {
    self.shouYeBtn.backgroundColor = [UIColor clearColor];
    self.setBtn.backgroundColor = [UIColor clearColor];
    self.locinBtn.backgroundColor = [UIColor clearColor];
    
button.backgroundColor = [UIColor colorWithRed:200.0 / 250 green:160.0 / 250 blue:130.0 / 250 alpha:0.7];
    NSLog(@"查找");
}
//设置
- (void)setBtnClick:(UIButton *)button {
    self.shouYeBtn.backgroundColor = [UIColor clearColor];
    self.findBtn.backgroundColor = [UIColor clearColor];
    self.locinBtn.backgroundColor = [UIColor clearColor];
    
button.backgroundColor = [UIColor colorWithRed:200.0 / 250 green:160.0 / 250 blue:130.0 / 250 alpha:0.7];
    NSLog(@"设置");
    
    //跳转到设置页面
    UIStoryboard * storyB = [UIStoryboard storyboardWithName:@"CJTableViewController" bundle:nil];
    CJTableViewController * tabbarVc = [storyB instantiateInitialViewController];
    
    [self presentViewController:tabbarVc animated:YES completion:nil];
    
    
}
//本地作品集
- (void)locinBtnClick:(UIButton *)button {
    self.shouYeBtn.backgroundColor = [UIColor clearColor];
    self.setBtn.backgroundColor = [UIColor clearColor];
    self.findBtn.backgroundColor = [UIColor clearColor];
    
button.backgroundColor = [UIColor colorWithRed:200.0 / 250 green:160.0 / 250 blue:130.0 / 250 alpha:0.7];
    NSLog(@"本地作品集");
    
    
    UIStoryboard * storyBoardL = [UIStoryboard storyboardWithName:@"CJLocaViewController" bundle:nil];
    CJLocaViewController * locaVc = [storyBoardL instantiateInitialViewController];
    
    [self presentViewController:locaVc animated:YES completion:nil];
    
    
}
@end
