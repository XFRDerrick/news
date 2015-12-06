//
//  NewsTableViewController.m
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "NewsTableViewController.h"

#import "NewsTableViewCell.h"

#import "News.h"
@interface NewsTableViewController ()

#pragma mark news的模型数组
@property (nonatomic, strong) NSArray *newsList;

@property (weak, nonatomic) IBOutlet UIView *HeaderContainerView;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHeaderContainerViewSize];

}


- (void)setHeaderContainerViewSize{

    self.HeaderContainerView.bounds = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 250);
    NSLog(@"ContainerView =%@",NSStringFromCGRect(self.HeaderContainerView.bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //获取模型进行判断Cell的类型
    News *news = self.newsList[indexPath.row];
    static NSString *identifiery = nil;
    //根据Cell的ID标识进行选择Cell重用
    if (news.imgType) {
        //大图
        identifiery = @"BigCell";
    }else if (news.imgextra.count == 2){
        identifiery = @"ThreeCell";
    }else{
    
        identifiery = @"BaseCell";
    }
    
    //重用Cell
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiery forIndexPath:indexPath];
    
    //为Cell赋值 模型
    cell.news = news;
    return cell;
}

#pragma mark 每个Cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    News *news = self.newsList[indexPath.row];
    //cell的告诉
    CGFloat height = 0;
    if (news.imgType) {
        height = 180;
    }else if (news.imgextra.count == 2){
    
        height = 120;
    }else{
    
        height = 80;
    }
    return height;

}


- (void)setURLString:(NSString *)URLString{

    _URLString = URLString;
    __weak typeof(self) weakSelf = self;
    [News newsWithURL:URLString finishedBlock:^(NSArray *news) {
        weakSelf.newsList = news;
    }];
}
- (void)setNewsList:(NSArray *)newsList{

    _newsList = newsList;
    //刷新表格
    [self.tableView reloadData];

}

@end
