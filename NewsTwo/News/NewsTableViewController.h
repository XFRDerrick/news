//
//  NewsTableViewController.h
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

#pragma mark 每一个频道对应一个新闻的URLString  利用URL赋值Cell
@property (nonatomic, copy) NSString *URLString;

@end
