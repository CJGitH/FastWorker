//
//  CJViewController.m
//  FastWorker
//
//  Created by chen on 16/5/7.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJViewController.h"
#import "NavButton.h"
#import "NavRightButton.h"
#import "UIView+Frame.h"

#import "CJCityViewController.h"
#import "CJFindViewController.h"
#import "CJFollowViewController.h"
#import "CJSettingViewController.h"

#import "CJCodeViewController.h"



@interface CJViewController ()<UIScrollViewDelegate>
/** 用来显示所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
//顶部的view
@property(nonatomic, strong)UIView *navTopView;
//设置左边的按钮
@property(nonatomic, strong)NavButton * leftBtn;
//设置右边的按钮
@property(nonatomic, strong)NavRightButton * rightBtn;
//给navTopView上加个view用于放底部三个按钮
@property(nonatomic, strong)UIView * titleBtnView;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) UIButton *previousClickedTitleButton;

/** 记录左侧按钮点击 */
//@property (nonatomic, weak) UIButton *leftButtonClickYesOrNo;

@property(nonatomic, strong)CJSettingViewController *settingVc;


@property(nonatomic, assign)NSInteger index;
//右侧遮盖的view
@property(nonatomic, strong)UIView * coverView;

@property(nonatomic, strong)CJFollowViewController * followVc;
@property(nonatomic, strong)CJFindViewController * findVc;
@property(nonatomic, strong)CJCityViewController * cityVc;
//**************************************
@property(nonatomic, strong)UIPanGestureRecognizer *pan;
@end


@implementation CJViewController

- (CJSettingViewController *)settingVc
{

    if (_settingVc == nil) {
        CJSettingViewController * settingVc = [[CJSettingViewController alloc]init];
        self.settingVc = settingVc;
        
        [self addChildViewController:settingVc];
    }
    return _settingVc;
    
}

- (UIView *)coverView
{

    if (_coverView == nil) {
        UIView * coverView = [[UIView alloc]init];
//        coverView.backgroundColor = [UIColor redColor];
        coverView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.7, 0, [UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width * 0.7, self.scrollView.bounds.size.height);
        coverView.alpha = 0.1;
//        [self.view addSubview:coverView];
        
        self.coverView = coverView;
    }
    return _coverView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //设置scrollView
//    [self setupScrollView];
    
    //顶部的view
    [self setupTopView];
    
    // 初始化子控制器
    [self setupChildVcs];
    
    //设置scrollView
    [self setupScrollView];
    
    //设置左边的按钮
    [self setupLiftBtn];
    
    //设置右边的按钮
    [self setupRightBtn];
    
    
    
    //给navTopView上加个view用于放底部三个按钮
    [self setupTitleBtnView];
    
    // 默认显示第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];

    /*
     //给遮盖的view添加手势(拖动手势)
     UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
     [self.coverView addGestureRecognizer:panRecognizer];
     */
    //给遮盖的view添加手势(拖动手势)
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.coverView addGestureRecognizer:panRecognizer];
    
}
- (UIPanGestureRecognizer *)pan:(UIPanGestureRecognizer *)pan {

    self.pan = pan;
    NSLog(@"---------------------------%@",pan);
    NSLog(@"拖动了view");
    //拖拽时,回到之前状态
    CGFloat w = [UIScreen mainScreen].bounds.size.width * 0.7;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //让右边的tableView动画出来
        self.settingVc.view.frame = CGRectMake(0, 0, -w, self.scrollView.bounds.size.height);

        //让顶部的uiv动画回来
        self.navTopView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        NSLog(@"%f",self.scrollView.contentOffset.x);
        //让scrollView动画回来
        //注意判断它本来的偏移量,在"关注"偏移是0,在"发现"偏移量是375,在"同城"偏移量是750
        //判断在哪个对应的按钮上再做动画
        //        self.scrollView.contentOffset = CGPointMake(w, 0);
        if (self.index == 0) {
            self.scrollView.contentOffset = CGPointMake(0, 0);
        }else if(self.index == 1) {
            
            self.scrollView.contentOffset = CGPointMake(375, 0);
        }else if(self.index == 2) {
            
            self.scrollView.contentOffset = CGPointMake(750, 0);
        }
        
    }];

    
    
    
    
    
    
    //移除遮盖的view
    [self.coverView removeFromSuperview];
    return nil;
}



#pragma mark -- 初始化子控制器
- (void)setupChildVcs {
    
    CJFollowViewController * followVc = [[CJFollowViewController alloc]init];
    self.followVc = followVc;
    [self addChildViewController:followVc];
    CJFindViewController * findVc = [[CJFindViewController alloc]init];
    self.findVc = findVc;
    [self addChildViewController:findVc];
    CJCityViewController * cityVc = [[CJCityViewController alloc]init];
    self.cityVc = cityVc;
    [self addChildViewController:cityVc];
}


#pragma mark -- //顶部的view
- (void)setupTopView {
    UIView *navTopView = [[UIView alloc]init];
    navTopView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
//    navTopView.frame = CGRectMake(self.scrollView.contentOffset.x, 0, [UIScreen mainScreen].bounds.size.width, 64);
    UIImageView * imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"bubble_rectangle_6"];
    imageV.frame = navTopView.bounds;
    [navTopView addSubview:imageV];
    [self.view addSubview:navTopView];
    self.navTopView = navTopView;
}

#pragma mark -- 设置左边的按钮
- (void)setupLiftBtn {
    //设置左边的按钮
    NavButton * leftBtn = [NavButton buttonWithType:UIButtonTypeCustom];
    [self.navTopView addSubview:leftBtn];
    [leftBtn setImage:[UIImage imageNamed:@"nav_btn_menu_white_normal"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"nav_btn_menu_black_pressed"] forState:UIControlStateHighlighted];
    [leftBtn sizeToFit];
    // 监听按钮点击
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = leftBtn;
}


//点击左侧按钮时调用
- (void)leftBtnClick:(UIButton *)leftButton {

//    CGFloat w = [UIScreen mainScreen].bounds.size.width * 0.7;
//    self.scrollView.contentInset = UIEdgeInsetsMake(0, w, 0, 0);
//    
//    CGFloat testX = self.scrollView.contentOffset.x;
//        self.settingVc.view.frame = CGRectMake(testX-w, 0, w, self.scrollView.cj_height);
//        [self.scrollView addSubview:self.settingVc.view];
//    
//    [UIView animateWithDuration:0.25 animations:^{
//                self.scrollView.contentOffset = CGPointMake(testX-w, 0);
//        
//        CGFloat navX = testX - w;
////        self.navTopView.frame.origin.x = navX;
//        self.navTopView.cj_x = - navX;
//        //        settingVc.view.cj_x = - w;
//        NSLog(@"%f",self.scrollView.frame.origin.x);
//        NSLog(@"%f",self.navTopView.frame.origin.x);
//        
//        NSLog(@"%f",self.scrollView.contentOffset.x);
//            }];

    
//    UIStoryboard * st = [UIStoryboard storyboardWithName:@"CJSettingViewController" bundle:nil];
//    CJSettingViewController * set = [[CJSettingViewController alloc]init];

//    UIViewController *vc = [st instantiateInitialViewController];

//    NSLog(@"%ld",(long)self.index);

    
//    CJSettingViewController * settingVc = [[CJSettingViewController alloc]init];
//    self.settingVc = settingVc;
    
    [self addChildViewController:self.settingVc];
    
    
    
    
    
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width * 0.7;
    
    
    self.settingVc.view.frame = CGRectMake(-w, 0, w, self.scrollView.bounds.size.height);
    
    [self.view addSubview:self.settingVc.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        //点击了按钮时,让右侧的剩余view不能点击,也就添加一个透明的view在上面
//        UIView * coverView = [[UIView alloc]init];
//        coverView.backgroundColor = [UIColor redColor];
//        coverView.frame = CGRectMake(w, 0, [UIScreen mainScreen].bounds.size.width - w, self.scrollView.bounds.size.height);
//        coverView.alpha = 0.2;
        [self.view addSubview:self.coverView];
        
        
        //让右边的tableView动画出来
        self.settingVc.view.frame = CGRectMake(0, 0, w, self.scrollView.bounds.size.height);
        //让顶部的uiv动画过去
        self.navTopView.frame = CGRectMake(w, 0, [UIScreen mainScreen].bounds.size.width, 64);
        NSLog(@"%f",self.scrollView.contentOffset.x);
        //让scrollView动画过去
        //注意判断它本来的偏移量,在"关注"偏移是0,在"发现"偏移量是375,在"同城"偏移量是750
        //判断在哪个对应的按钮上再做动画
//        self.scrollView.contentOffset = CGPointMake(w, 0);
        
        if (self.index == 0) {
            self.scrollView.contentOffset = CGPointMake(-w, 0);
//            self.scrollView.contentSize = CGSizeMake(-w, 0);
        }else if(self.index == 1) {
        

            self.scrollView.contentOffset = CGPointMake(-w + 375, 0);
        }else if(self.index == 2) {
        

            self.scrollView.contentOffset = CGPointMake(-w + 750, 0);
        }
        
    }completion:^(BOOL finished) {
        //动画完成之后调用
        NSLog(@"动画完成");
    }];

    
}



#pragma mark -- 设置右边的按钮
- (void)setupRightBtn {
    //设置右边的按钮
    NavRightButton * rightBtn = [NavRightButton buttonWithType:UIButtonTypeCustom];
    [self.navTopView addSubview:rightBtn];
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_camera_normal"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_camera_black_normal"] forState:UIControlStateHighlighted];
    //监听按钮的点击事件
    [rightBtn addTarget:self action:@selector(rightBrnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn sizeToFit];
}


//点击右侧按钮时调用
- (void)rightBrnClick {
    
    UIStoryboard * codeStoryB = [UIStoryboard storyboardWithName:@"CJCodeViewController" bundle:nil];
    CJCodeViewController * codeVc = [codeStoryB instantiateInitialViewController];

//    [self.navigationController pushViewController:codeVc animated:YES];
    
    [self presentViewController:codeVc animated:YES completion:nil];
    NSLog(@"点击了右侧按钮");
}





#pragma mark -- 给navTopView上加个view用于放底部三个按钮
- (void)setupTitleBtnView {
    CGFloat x = 15 + self.leftBtn.frame.size.width;
    CGFloat y = 20;
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 2 * x;
    CGFloat h = 44;
    CGRect rect = CGRectMake(x, y, w, h);
    UIView * titleBtnView = [[UIView alloc]initWithFrame:rect];
//    titleBtnView.backgroundColor = [UIColor redColor];
    [self.navTopView addSubview:titleBtnView];
    self.titleBtnView = titleBtnView;

    //加载按钮
    [self setCenterButton];
    
    //设置下划线
    [self setupTitleUnderline];
    
}

#pragma mark -- 设置中间三个按钮
- (void)setCenterButton {
    NSArray * array = @[@"关注",@"发现",@"同城"];
    NSUInteger count = array.count;
    CGFloat titleBtnH = self.titleBtnView.frame.size.height;
    CGFloat titleBtnW = self.titleBtnView.frame.size.width / count;
    for (int i = 0; i < count; i++) {
        
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake(titleBtnW * i, 0, titleBtnW, titleBtnH);
        [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtnView addSubview:btn];
        
    }
    
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
    self.scrollView = scrollView;
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    //设置contentSize
    scrollView.contentSize = CGSizeMake(count * scrollView.cj_width, 0);
    scrollView.pagingEnabled = YES;
//    [self.view addSubview:scrollView];
    [self.view insertSubview:scrollView atIndex:0];
    
    
}


#pragma mark -- 设置下划线
- (void)setupTitleUnderline {
    //取出标题按钮
    UIButton *firstTitleButton = self.titleBtnView.subviews.firstObject;
    
    //设置UIView
    UIView *titleUnderLine = [[UIView alloc]init];
    self.titleUnderline = titleUnderLine;
    CGFloat titleUnderLineH = 2;
    CGFloat titleUnderLineY = self.titleBtnView.frame.size.height - titleUnderLineH;
    titleUnderLine.frame = CGRectMake(0, titleUnderLineY, 0, titleUnderLineH);
    titleUnderLine.backgroundColor = [firstTitleButton titleColorForState:UIControlStateNormal];
    [self.titleBtnView addSubview:titleUnderLine];
    
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit];
    self.titleUnderline.cj_width = firstTitleButton.titleLabel.frame.size.width;
    self.titleUnderline.cj_centerX = firstTitleButton.center.x;
    
}

#pragma mark - 监听点击
- (void)titleButtonClick:(UIButton *)titleButton {

    //设置上一次的点击按钮为no
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    //设置下划线的滑动
    NSInteger index = titleButton.tag;
    self.index = index;
    [UIView animateWithDuration:0.25 animations:^{
        //下划线
        self.titleUnderline.cj_width = titleButton.titleLabel.cj_width;
        self.titleUnderline.cj_centerX = titleButton.cj_centerX;
        
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
    UIViewController * childVc = self.childViewControllers[index];
    //做优化,如果哦有就不创建,没有就创建
    if (childVc.isViewLoaded) return;
    
    //设置frame
    childVc.view.frame = CGRectMake(index * self.scrollView.cj_width, 0, self.scrollView.cj_width, self.scrollView.cj_height);
    
    //添加到scrollView中
    [self.scrollView addSubview:childVc.view];
    
}


#pragma mark -- 实现scrollView的代理方法
//当滚动停止时,让下划线滚动到对应的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    NSInteger index = scrollView.contentOffset.x / scrollView.cj_width;
    UIButton * titleButton = self.titleBtnView.subviews[index];
    [self titleButtonClick:titleButton];
    
    //移除设置控制器
        [self.settingVc.view removeFromSuperview];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    //移除设置控制器
        [self.settingVc.view removeFromSuperview];
    NSLog(@"正在拖拽时调用");
}
@end
