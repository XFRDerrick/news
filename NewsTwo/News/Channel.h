//
//  Channel.h
//  News
//
//  Created by 赫腾飞 on 15/11/24.
//  Copyright © 2015年 hetefe. All rights reserved.
//
/**
 *         {"template":"manual",
            "topicid":"000503RV",
            "hasCover":false,
            "alias":"NBA",
            "subnum":"2.7万",
            "recommendOrder":108,
            "isNew":0,
            "img":"T1348649145984",
            "isHot":0,
            "hasIcon":true,
            "cid":"C1348649048655",
            "recommend":"1",
            "headLine":false,
            "color":"",
            "bannerOrder":70,
            "tname":"NBA",
            "ename":"NBA",
            "showType":"comment",
            "special":0,
            "tid":"T1348649145984"},
 */
#import <Foundation/Foundation.h>

@interface Channel : NSObject


#pragma mark 频道ID
@property (nonatomic, copy) NSString *tid;


#pragma mark 频道名字
@property (nonatomic, copy) NSString *tname;


#pragma mark 每个频道对应一个URLString
@property (nonatomic, copy, readonly) NSString *tidURLString;

#pragma mark 类方法快速创建频道的数组
+ (NSArray *)channels;

@end
