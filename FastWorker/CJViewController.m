//
//  CJViewController.m
//  FastWorker
//
//  Created by chen on 16/5/6.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJViewController.h"
#import "NavButton.h"
#import "NavRightButton.h"
#import "UIView+Frame.h"

#import "CJCityViewController.h"
#import "CJFindViewController.h"
#include "CJFollowViewController.h"

#import "CJSettingViewController.h"


@interface CJViewController ()<UIScrollViewDelegate>
/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
//左侧按钮
@property(nonatomic, strong)UIButton *leftButton;
//右侧按钮
@property(nonatomic, strong)UIButton *rightButton;
//中间的放按钮的view
@property(nonatomic, strong)UIView *btnView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) UIButton *previousClickedTitleButton;

@end

@implementation CJViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加左侧菜单按钮
    [self setLeftNavButton];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    //添加右侧视频按钮
    [self setRightVideoButton];
    
    //设置scrollView
    [self setupScrollView];
    
    //设置标题的view
    [self setupTitlesView];
    
    // 默认显示第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
}

#pragma mark -- 初始化子控制器
- (void)setupChildVcs {

    [self addChildViewController:[[CJFollowViewController alloc]init]];
    [self addChildViewController:[[CJFindViewController alloc]init]];
    [self addChildViewController:[[CJCityViewController alloc]init]];
    
}

#pragma mark -- 添加左侧菜单按钮
- (void)setLeftNavButton {
    //左侧按钮
    NavButton *btn = [NavButton buttonWithType:UIButtonTypeCustom];
    self.leftButton = btn;
    [btn setImage:[UIImage imageNamed:@"nav_btn_menu_white_normal"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_btn_menu_black_pressed"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    // 监听按钮点击
    [btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //包装一下
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    UIBarButtonItem* btnItems = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    self.navigationItem.leftBarButtonItem = btnItems;
    
}

#pragma mark -- 添加右侧视频按钮
- (void)setRightVideoButton {
    //右侧按钮
    NavRightButton * rightBtn = [NavRightButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightBtn;
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_camera_normal"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_camera_black_normal"] forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];
    //监听按钮的点击事件
    [rightBtn addTarget:self action:@selector(rightBrnClick) forControlEvents:UIControlEventTouchUpInside];
    UIView * rightBtnV = [[UIView alloc]initWithFrame:rightBtn.bounds];
    [rightBtnV addSubview:rightBtn];
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnV];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

#pragma mark -- 设置标题的view
- (void)setupTitlesView {
    //设置中间
    CGFloat x = self.leftButton.frame.origin.x + self.leftButton.frame.size.width;
    CGFloat y = 20;
    CGFloat w = [UIScreen mainScreen].bounds.size.width - (self.rightButton.frame.size.width + self.leftButton.bounds.size.width);
    CGFloat h = 44;
    CGRect rect = CGRectMake(x, y, w, h);
    UIView * addBtnView = [[UIView alloc]initWithFrame:rect];
    self.btnView = addBtnView;
    //        addBtnView.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = addBtnView;
    
    //加载按钮
    [self setCenterButton];
    
    //设置下划线
    [self setupTitleUnderline];
}

#pragma mark -- 设置中间三个按钮
- (void)setCenterButton {
    NSArray * array = @[@"关注",@"发现",@"同城"];
    NSUInteger count = array.count;
    CGFloat titleBtnH = self.btnView.frame.size.height;
    CGFloat titleBtnW = self.btnView.frame.size.width / count;
    for (int i = 0; i < count; i++) {
        
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake(titleBtnW * i - 22, 0, titleBtnW, titleBtnH);
        [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:btn];
        
    }
    
}

#pragma mark -- 设置下划线
- (void)setupTitleUnderline {
    //取出标题按钮
    UIButton *firstTitleButton = self.btnView.subviews.firstObject;

    //设置UIView
    UIView *titleUnderLine = [[UIView alloc]init];
    self.titleUnderline = titleUnderLine;
    CGFloat titleUnderLineH = 3;
    CGFloat titleUnderLineY = self.btnView.frame.size.height - titleUnderLineH;
    titleUnderLine.frame = CGRectMake(0, titleUnderLineY, 0, titleUnderLineH);
    titleUnderLine.backgroundColor = [firstTitleButton titleColorForState:UIControlStateNormal];
    [self.btnView addSubview:titleUnderLine];
    
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.cj_width = firstTitleButton.titleLabel.frame.size.width;
    self.titleUnderline.cj_centerX = firstTitleButton.center.x;
    
}

#pragma mark -- 设置scrollView
- (void)setupScrollView
{
    /*
     NSInteger count = self.childViewControllers.count;
     // 不要去自动调整scrollView的内边距
     self.automaticallyAdjustsScrollViewInsets = NO;
     // 点击状态栏时,这个scrollView不需要滚动到顶部
     scrollView.scrollsToTop = NO;
     */
    
    NSInteger count = self.childViewControllers.count;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //设置contentSize
    scrollView.contentSize = CGSizeMake(count * scrollView.cj_width, 0);
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
}

#pragma mark -- 实现scrollView的代理方法
//当滚动停止时,让下划线滚动到对应的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.cj_width;
    UIButton * titleButton = self.btnView.subviews[index];
    [self titleButtonClick:titleButton];
}

#pragma mark - 监听点击
- (void)titleButtonClick:(UIButton *)titleButton {

    //设置上一次的点击按钮为no
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    //设置下划线的滑动
    NSInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        self.titleUnderline.cj_width = titleButton.titleLabel.cj_width;
        self.titleUnderline.cj_centerX = titleButton.cj_centerX;
        
        /*
         // 滑动scrollView到对应的子控制器界面
         CGPoint offset = self.scrollView.contentOffset;
         offset.x = index * self.scrollView.xmg_width;
         self.scrollView.contentOffset = offset;
         */
        // 滑动scrollView到对应的子控制器界面
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = index * self.scrollView.cj_width;
        self.scrollView.contentOffset = offset;
        
    } completion:^(BOOL finished) {
        // 添加index位置的子控制器view到scrollView中
        [self addChildVcViewIntoScrollView:index];
    }];
    
    
}

#pragma mark -- 添加index位置的子控制器view到scrollView中
- (void)addChildVcViewIntoScrollView:(NSInteger)index {
    //取出对应的子控制器
    UICollectionViewController * childVc = self.childViewControllers[index];
    //做优化,如果哦有就不创建,没有就创建
    if (childVc.isViewLoaded) return;
    
    //设置frame
    childVc.view.frame = CGRectMake(index * self.scrollView.cj_width, 0, self.scrollView.cj_width, self.scrollView.cj_height);
    
    //添加到scrollView中
    [self.scrollView addSubview:childVc.view];
    
}

//点击左侧按钮时调用
- (void)leftBtnClick {

//    CJSettingViewController * settingVc = [[CJSettingViewController alloc]init];
////    [self presentViewController:settingVc animated:YES completion:nil];
//    [self.navigationController pushViewController:settingVc animated:YES]
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width * 0.7;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, w, 0, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(-w, 0);

    }];
    
}

- (void)rightBrnClick {

    NSLog(@"点击了右侧按钮");
}

@end
