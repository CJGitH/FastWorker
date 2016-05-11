//
//  CJFindViewController.m
//  FastWorker
//
//  Created by chen on 16/5/7.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "CJFindViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UICollectionViewWaterfallLayout.h"

@interface CJFindViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout>

@end

@implementation CJFindViewController

static NSString * const reuseIdentifier = @"Cell";


#define kItemWidth 100.0f
#define kColumnCount 2
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NSArray *arr = @[@"dkldkl",@"cc",@"cdskclsdlck",@"1"];
    
    
    UICollectionViewWaterfallLayout *layout = [UICollectionViewWaterfallLayout new];
    layout.delegate = self;
    layout.columnCount = kColumnCount;
    layout.itemWidth = kItemWidth;
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    
    UICollectionView *vc = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    vc.delegate = self;
    vc.dataSource = self;
    vc.backgroundColor = [UIColor whiteColor];
    [vc registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:vc];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api2.hichao.com/stars?category=%E5%85%A8%E9%83%A8" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.resultDict = responseObject;
        [vc reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray *)self.resultDict[@"data"][@"items"]).count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = (NSArray *)self.resultDict[@"data"][@"items"];
    
    NSDictionary *dic = array[indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *view = (UIImageView *)[cell.contentView viewWithTag:100];
    [view removeFromSuperview];
    UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    imagV.tag = 100;
    
    
    [imagV sd_setImageWithURL: [NSURL URLWithString:dic[@"component"][@"picUrl"]] ];
    
    
    [cell.contentView addSubview:imagV];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateWaterfallLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict =((NSArray *)self.resultDict[@"data"][@"items"])[indexPath.row];
    float width = [dict[@"width"] floatValue];
    float height = [dict[@"height"] floatValue];
    height = kItemWidth * height / width;
    return height;
    
}
@end
