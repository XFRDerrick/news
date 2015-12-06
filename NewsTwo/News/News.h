//
//  News.h
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishedBlock)(NSArray *news);
@interface News : NSObject


#pragma mark 标题
@property (nonatomic, copy) NSString *title;


#pragma mark 摘要
@property (nonatomic, copy) NSString *digest;


#pragma mark 图片
@property (nonatomic, copy) NSString *imgsrc;


#pragma mark 跟帖数
@property (nonatomic, assign) int replyCount;


#pragma mark 多张配图
@property (nonatomic, strong) NSArray *imgextra;

#pragma mark 大图标记
@property (nonatomic, assign) BOOL imgType;

#pragma mark 根据URLString去加载我们的新闻数据，最后返回给控制器

+ (void)newsWithURL:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock;


@end
