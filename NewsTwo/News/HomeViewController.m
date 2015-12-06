//
//  ViewController.m
//  News
//
//  Created by 赫腾飞 on 15/11/24.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "HomeViewController.h"

#import "Channel.h"

#import "ChannelLable.h"
#import "ContentCell.h"
#import "NewsTableViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *baseView;

#pragma mark 标题的数据,数组类型
@property (nonatomic, copy) NSArray *channels;

@property (weak, nonatomic) IBOutlet UIScrollView *cannelScrollView;

#pragma mark 对应内容视图
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

#pragma mark 内容视图的布局，CollectionCell
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *contentFlowLayout;


#pragma mark channelLables的可变数组
@property (nonatomic, strong) NSMutableArray *channelLables;


#pragma mark currentLable
@property (nonatomic, strong) ChannelLable *currentLable;

#pragma mark currentCollectionCellValue
@property (nonatomic, assign) CGFloat currentValue;


@end

@implementation HomeViewController
//初始化
- (NSMutableArray *)channelLables{

    if (_channelLables == nil) {
        _channelLables = [NSMutableArray array];
    }
    return _channelLables;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建lable
    [self creatChannelLables];
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.delegate = self;
}


//再将要显示的时候对collectionView，进行设置
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //
    [self setupContentViewLayout];
    
    //设置默认的Lable
    
    
}

- (void)setupContentViewLayout{

    //设置每一个item的大小,占满视图
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.mainCollectionView.bounds = CGRectMake(0, 0, size.width, size.height-108);
    self.contentFlowLayout.itemSize = self.mainCollectionView.bounds.size;
    
    //设置最小间距（XY方向）
    self.contentFlowLayout.minimumInteritemSpacing = 0  ;
    self.contentFlowLayout.minimumLineSpacing = 0;
    
    
}

#pragma mark collection的数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentCell" forIndexPath:indexPath];
    
    //获取模型频道
    Channel *channel = self.channels[indexPath.item];
    cell.URLString = channel.tidURLString;
    return cell;
    
}


#pragma mark 创建频道的lable
- (void)creatChannelLables{

    self.currentLable.tag = 0;
    //需要创建多少个lable
    NSInteger count = self.channels.count;
    //lable的frame计算
    CGFloat channelLabW = 70;
    CGFloat channelLabH = self.cannelScrollView.bounds.size.height;
    CGFloat channelLabY = 0;
    
    //循环创建
    for (int i = 0; i<count; i++) {
        //创建lable
        ChannelLable *channelLab = [[ChannelLable alloc] init];
       
        //为每一个Lable设置tag，方便获取当前对应的Lable
        channelLab.tag = i;
        
        //设置frame
        CGFloat channelLabX = i * (channelLabW + 0);
        channelLab.frame = CGRectMake(channelLabX, channelLabY, channelLabW, channelLabH);
       
        //赋值
        channelLab.text = [self.channels[i] tname];
        
        //添加到父控件
        [self.cannelScrollView addSubview:channelLab];
        
        /**
         *  为每一个Lable添加手势动作,lable添加功能
         */
        channelLab.userInteractionEnabled = YES;
        [channelLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelLableClick:)]];
        
        //将Lable添加到数组中去
        [self.channelLables addObject:channelLab];
        
    }
    //设置ScrollView的偏移量，可以滑动
    self.cannelScrollView.contentSize = CGSizeMake(channelLabW * count, 0);
    
    //消除水平和垂直方向的滚动条
    self.cannelScrollView.showsVerticalScrollIndicator = NO;
    self.cannelScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark channelLable 的点击动作
- (void)channelLableClick:(UITapGestureRecognizer *)recognizer{

    NSLog(@"点击了channelLable %ld",(long)[(ChannelLable *)recognizer.view tag]);
    //切换我们的新闻内容
    self.currentLable = (ChannelLable *)recognizer.view;
    
    CGFloat index = self.currentLable.tag;
    /**
     *  如果要调用ScrollViewDIdEndScrolllingAnimation
     *
     *  setContentOffset  animation 设置为yes
     */
    [self.mainCollectionView setContentOffset:CGPointMake(index * self.mainCollectionView.bounds.size.width, 0) animated:YES];
    
//    [self scrollViewDidEndScrollingAnimation:self.cannelScrollView];
    [self didWhenClickChannelLable:(int)self.currentLable.tag];

}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"%s",__func__);
    //计算当前的indexCell的  value
   
    CGFloat value = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSLog(@"%f,%f",self.currentValue,value);
    CGFloat maxOffSexX = self.channelLables.count - 1;
    if (self.currentValue <0 ) {
        self.currentValue = 0;
    }else if (self.currentValue > maxOffSexX){
        self.currentValue = maxOffSexX;
    }
    //需要进行的动作，对Lable进行自动滑动（设置Lable的contentOffset），需要获取的是
    CGFloat scale = value - self.currentLable.tag;
    
    
    int nextIndex = scale ? (int)(self.currentLable.tag + 1) : (int)(self.currentLable.tag - 1);//(value - self.currentValue + self.currentLable.tag) / 1;
    
     self.currentValue = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    CGFloat nextScale = (NSUInteger)scale;
    //设置下一个Lable字体的scale
    ChannelLable *nextlLable = self.channelLables[nextIndex];
    nextlLable.scale = nextScale;
    //当前Lable的渐变
    self.currentLable.scale = 1 - nextScale;
    
    NSLog(@"%ld,%d",(long)self.currentLable.tag,nextIndex);
    [self didWhenClickChannelLable:nextIndex];
//    self.currentLable = self.channelLables[ne]

}
*/

#pragma mark ScrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%s",__func__);
    //获取到滚动的范围
    CGFloat value = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    CGFloat maxOffsexX = (self.channelLables.count - 1);
    if (value < 0 || value > maxOffsexX) {
        return;
    }
    //左边的索引？？
    int leftIndex = (int)scrollView.contentOffset.x / scrollView.bounds.size.width;
    //右边的索引
    int rightIndex = leftIndex + 1;
    //右边的缩放比例，
    CGFloat rightScale = value - leftIndex;
    
    //左边的缩放比率
    CGFloat leftScale = 1 - rightScale;
    
    ChannelLable *leftChannelLable = self.channelLables[leftIndex];
    
    leftChannelLable.scale = leftScale;
    
    if (rightIndex < self.channelLables.count) {
        ChannelLable *rightChannelLable = self.channelLables[rightIndex];
        rightChannelLable.scale = rightIndex;
    }

}


#pragma mark ...
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  NSLog(@"%s",__func__);
    //需要将我们的channelScrollView里面对应的channelLable显示在中间
//    [self scrollViewDidEndScrollingAnimation:scrollView];
    [self didWhenClickChannelLable:(int)self.currentLable.tag];
}

#pragma mark 这个方法可以作为一个公共的方法来调用，也可以自己创建一个公共的方法，可以在两个地方调用，一个是当我点击了channelScrollView的时候
//当点击Lable的时候进行调用
- (void)didWhenClickChannelLable:(int)lableTag{
    
    //获取当前的索引
    int currentIndex = lableTag;//(0...n)
    //当前索引对应的Lable
    ChannelLable *channelLable = self.channelLables[currentIndex];
    CGFloat channelLableCenterX = channelLable.center.x;
   
//    NSLog(@"%f",channelLable.center.x);
    
    CGFloat offsexValue = channelLableCenterX - self.cannelScrollView.bounds.size.width * 0.5;
    //最大滚动范围
    
    CGFloat maxOffaexValue = self.cannelScrollView.contentSize.width - self.cannelScrollView.bounds.size.width;
    
    if (offsexValue < 0) {
        offsexValue = 0;
    }else if (offsexValue > maxOffaexValue){
    
        offsexValue = maxOffaexValue;
    }
    [self.cannelScrollView setContentOffset:CGPointMake(offsexValue, 0) animated:YES];
    
    //设置scale
//
//    for (ChannelLable *channelLable in self.channelLables) {
//        if (channelLable.tag == currentIndex) {
//            channelLable.scale = 1.0;
//        }else{
//            channelLable.scale = 0.0;
//        }
//    }
    
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
      NSLog(@"%s",__func__);
    
    for (ChannelLable *channelLable in self.channelLables) {
        if (channelLable.tag == self.currentLable.tag - 1) {
            channelLable.scale = 1.0;
        }else{
            channelLable.scale = 0.0;
        }
    }
 
    [self didWhenClickChannelLable:(int)self.currentLable.tag];
    
}


#pragma mark 懒加载数据

- (NSArray *)channels{
    if (_channels == nil) {
        _channels = [Channel channels];
    }
    return _channels;
}


@end
