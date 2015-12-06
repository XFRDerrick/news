//
//  CycleCVController.m
//  News
//
//  Created by 赫腾飞 on 15/11/26.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "CycleCVController.h"

#import "Cycles.h"
#import "CycleCVCell.h"
#import <PureLayout/PureLayout.h>
#import <objc/runtime.h>

#define MinSection 3

@interface CycleCVController ()<UICollectionViewDataSource>

#pragma mark 数据数组
@property (nonatomic, strong) NSArray *cycleList;

/**
 *  自定义pageControl
 */
@property (weak ,nonatomic) UIPageControl *pageControl;

//设置Cell的大小
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cycleFlowLayout;


@end

@implementation CycleCVController

static NSString * const reuseIdentifier = @"Cell";

//再将要显示的时候对collectionView，进行设置
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //
    [self setupContentViewLayout];
}

- (void)setupContentViewLayout{
    //为collectionView设置代理
    self.collectionView.dataSource = self;
    
    //为每一个Cell设置size
    self.cycleFlowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
    
    NSLog(@"\n self.collectionView.bounds = %@,\n self.cycleFlowLayout.itemSize = %@",NSStringFromCGRect(self.collectionView.bounds),NSStringFromCGSize(self.cycleFlowLayout.itemSize));

    //设置最小间距（XY方向）
    self.cycleFlowLayout.minimumInteritemSpacing = 0  ;
    self.cycleFlowLayout.minimumLineSpacing = 0;
    
    NSLog(@"self.view.bounds =%@",NSStringFromCGRect(self.view.bounds));
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //创建pageControl
    [self setUpPageControl];
    //更新
    [self loadData];
}

- (void)getUIPageControlPrivate{

    NSMutableArray *properties = [NSMutableArray array];
    
    unsigned int count = 0;
    
    // Class_copyIvarList 既可以拿到公有属性，也可以拿到私有属性
    Ivar *propertyArray = class_copyIvarList([UIPageControl class], &count);
    
    for (int i =0; i<count; i++) {
        Ivar ivar = propertyArray[i];
        
        const char *cPropertyName = ivar_getName(ivar);
        
        NSString *propertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        
        [properties addObject:propertyName];
    }
    free(propertyArray);
}

- (void)loadData{
    
    __weak typeof(self) weakSelf = self;
    
    [Cycles headlinesWithFinishedBlock:^(NSArray *cycleList) {
        weakSelf.cycleList = cycleList;
        
        //设置总页面
        weakSelf.pageControl.numberOfPages = cycleList.count;
    }];
}

- (void)setUpPageControl{

    //创建一个pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    //添加到父控件上，在pureLayout使用之前一定要先加入到父控件上
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    //
    [pageControl autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-10];
    
    [pageControl autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view withOffset:3];
    
    //设置我们的图片，来替换原来的圆圈
    
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    
    
}

- (void)setCycleList:(NSArray *)cycleList{

    _cycleList = cycleList;
    
    [self.collectionView reloadData];
    
    //通过无动画的方式自动滚动到中间的那组去
    //创建最中间的那组
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:MinSection/2];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

#pragma mark <UICollectionViewDataSource>

/**
 * 创建了三组相同的图片
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return MinSection;
}

//行
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cycleList.count;
}

//每个Cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CycleCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleCell" forIndexPath:indexPath];
    
    cell.cycle = self.cycleList[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
   
    //通过无动画的方式跳到最中间的那组
    
    int currentPage = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    
    currentPage = currentPage % self.cycleList.count;
    
    self.pageControl.currentPage = currentPage;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage inSection:MinSection / 2];

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

@end
