//
//  ChannelLable.m
//  News
//
//  Created by 赫腾飞 on 15/11/24.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "ChannelLable.h"

@implementation ChannelLable

- (instancetype)init{

    if (self = [super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:20];
        //让其可以点击
        self.userInteractionEnabled = YES;
        //默认缩放为0
        self.scale = 0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    //设置scale之后的一些属性
    //设置颜色的渐变
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    //最小只能缩放到原来的80%
    CGFloat minScaleRate = 0.8;
    CGFloat realScale = minScaleRate + (1 - minScaleRate) *scale;
    
    //设置我们的transform
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
    

}

@end
