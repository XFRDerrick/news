//
//  News.m
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "News.h"

#import "NetWorkTool.h"

#import <objc/runtime.h>

@implementation News

/**
 *  获取需要的属性
 */

+ (NSArray *)properties{

    NSMutableArray *properties = [NSMutableArray array];
    //我们一个属性的个数
    unsigned int count = 0;
    
    //propertyArray相当于一个数组
    objc_property_t *propertyArray = class_copyPropertyList([News class], &count);
    
    for (int i = 0; i<count; i++) {
        //获取到类的每一个属性
        objc_property_t property = propertyArray[i];
        //进一步获取我们属性的名称
        const char *cPropertyName = property_getName(property);
        
        //将C语言中的属性名称转换成我们OC的字符串
        NSString *propertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        
        [properties addObject:propertyName];
        
    }
    //在C 中 存在 内存问题  需要手动释放
    free(propertyArray);
    return properties.copy;
}

+ (instancetype)newsWithDict:(NSDictionary *)dict{

    id obj = [[self alloc] init];
    //利用kvc赋值
    NSArray *properties = [self properties];
    
    for (NSString *propertyName in properties) {
        if (dict[propertyName] != nil ) {
            [obj setValue:dict[propertyName] forKey:propertyName];
        }
    }
    return obj;
}

+ (void)newsWithURL:(NSString *)URLString finishedBlock:(FinishedBlock)finishedBlock{

    [[NetWorkTool sharedNetWorkTool] GET:URLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        [self properties];
//        NSLog(@"result = %@",responseObject);
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        
        NSEnumerator *enumerator = resultDict.keyEnumerator;
        
        NSString *key = enumerator.nextObject;
        //取到我们新闻的字典数组
        NSArray *dictArray = resultDict[key];
        
        //定义一个数组模型
        NSMutableArray *newList = [NSMutableArray array];
        
        //将字典数组转换成模型
        [dictArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //kvc 赋值并且保存到数组中
            News *news = [News newsWithDict:obj];
            [newList addObject:news];
        }];
        //回调给我们的控制器
        if (finishedBlock) {
            finishedBlock(newList);
        }
    
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
        
}


@end
