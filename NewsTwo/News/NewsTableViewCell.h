//
//  NewsTableViewCell.h
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;

@interface NewsTableViewCell : UITableViewCell

#pragma mark 模型
@property (nonatomic, strong) News *news;

@end
