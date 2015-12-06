//
//  Channel.m
//  News
//
//  Created by 赫腾飞 on 15/11/24.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "Channel.h"

@implementation Channel

- (void)setTid:(NSString *)tid{

    _tid = tid;
    
    _tidURLString = [NSString stringWithFormat:@"article/list/%@/0-40.html",_tid];
//    NSLog(@"%@",_tidURLString);
}

+ (NSArray *)properties{

    return @[@"tid",@"tname"];
}

- (NSString *)description{

    return [NSString stringWithFormat:@"%@  %@",self.tid,self.tname];
}

+ (instancetype)channelWithDict:(NSDictionary *)dict{

    Channel *channel = [[Channel alloc] init];
    // 相当  模型数组类型
    NSArray *properties = [self properties];
    //利用kvc为模赋值
    for (NSString *property in properties) {
        if (dict[property] != nil) {
            //只获取部分字典中对应属相的数据，
//            NSLog(@"%@",dict[property]);
            //对对应的模型中的对应属性 进行赋值
            [channel setValue:dict[property] forKey:property];
        }
    }
    return channel;
}

+ (NSArray *)channels{

    //获取信息并解析赋值
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    
    //序列化
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //转换成字典 JSON解析成
    NSDictionary *channelDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    //取出字典中tList对应的数组，他是一个字典数组
    NSArray *dictArray = channelDict[@"tList"];
    
//    NSLog(@"%@",dictArray);
    //创建一个数组模型
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //遍历字典 存放title信息的字典数组
    /**
     *  遍历字典的内容包含信息
     *
     *  @param key  字典类型的数据-信息（单条信息的数据字典）
     *  @param obj  应该是序号NSInteger
     *  @param stop
     */
    
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary *key, NSUInteger obj, BOOL * _Nonnull stop) {
        
//        NSLog(@"%@",key);
        //将字典转化成模型
        Channel *channel = [Channel channelWithDict:key];
        
#warning *******调试数据未存入的问题***
//        NSLog(@"%@",channel.tname);
        
        //将模型存入到数组中去
        [arrayM addObject:channel];
    }];
    //对数据进行排序确认内容的有序性
    //利用tid来从小到大进行排序
    [arrayM sortUsingComparator:^NSComparisonResult(Channel *obj1, Channel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    //返回不可变的数组，使用copy
    return arrayM.copy;
}

@end
