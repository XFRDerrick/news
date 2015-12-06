//
//  ContentCell.m
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "ContentCell.h"
#import "NewsTableViewController.h"

@interface ContentCell ()

#pragma mark vc
@property (nonatomic, strong)NewsTableViewController *newsCOntroller;

@end

@implementation ContentCell

- (void)awakeFromNib{
    
    //加载控制器
    UIStoryboard *newsStoryBoard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsCOntroller = [newsStoryBoard instantiateInitialViewController];
    //添加到View
    [self.contentView addSubview:self.newsCOntroller.view];
    //设置控制器大小
    self.newsCOntroller.view.frame = self.bounds;
    
    //随机颜色
//    self.contentView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
//    NSLog(@"%f",self.contentView.bounds.size.width);
}

- (void)setURLString:(NSString *)URLString{
    //为其提供数据
    _URLString = URLString;
    self.newsCOntroller.URLString = URLString;
    
}

@end
