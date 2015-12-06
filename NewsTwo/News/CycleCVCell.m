//
//  CycleCVCell.m
//  News
//
//  Created by 赫腾飞 on 15/11/26.
//  Copyright © 2015年 hetefe. All rights reserved.
//


#import "CycleCVCell.h"

#import <UIImageView+AFNetworking.h>

#import "Cycles.h"

@interface CycleCVCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation CycleCVCell


- (void)setCycle:(Cycles *)cycle{

    
    _cycle = cycle;
    //为Cell的设置图片
    [self.iconView setImageWithURL:[NSURL URLWithString:cycle.imgsrc]];
    //设置title
    self.titleLable.text = cycle.title;
    
}


@end
