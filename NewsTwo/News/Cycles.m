//
//  Cycles.m
//  
//
//  Created by 赫腾飞 on 15/11/26.
//
//

#import "Cycles.h"

#import "NetWorkTool.h"

#import <objc/runtime.h>

@implementation Cycles


/**
 *  获取需要的属性
 */

+ (NSArray *)properties{

    NSMutableArray *properties = [NSMutableArray array];
    
    //属性个数
    unsigned int count = 0;
    //数组属性
    objc_property_t *propertyArray = class_copyPropertyList([Cycles class], &count);
    for (int i =0; i< count; i++) {
        //获取到类的每一个属性
        objc_property_t proterty = propertyArray[i];
        
        //获取属性的名称
        const char *cPropertyName = property_getName(proterty);
        //有C语言中的字符串 转换成OC中的字符串获取属性名
        NSString *propertyName = [[NSString alloc] initWithCString:cPropertyName encoding:NSUTF8StringEncoding];
        //添加到属性数组
        [properties addObject:propertyName];
        
    }
    return properties.copy;

}

+ (instancetype)cycleWithDict:(NSDictionary *)dict{

    id obj = [[self alloc] init];
    
    NSArray *properties = [self properties];
    
    for (NSString *propertyName in properties) {
        if (dict[propertyName] != nil) {
            [obj setValue:dict[propertyName] forKey:propertyName];
        }
    }
    return obj;
}

+ (void)headlinesWithFinishedBlock:(FinishedBlock)finishedBlock{

    [[NetWorkTool sharedNetWorkTool] GET:@"ad/headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSArray *dictArray = responseObject[@"headline_ad"];
        //字典转换成模型
        NSMutableArray *cycleList = [NSMutableArray array];
        [dictArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            Cycles *cycle = [Cycles cycleWithDict:obj];
            [cycleList addObject:cycle];
            
        }];
        
        if (finishedBlock) {
            finishedBlock(cycleList.copy);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

@end
