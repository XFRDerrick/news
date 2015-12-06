//
//  NetWorkTool.m
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import "NetWorkTool.h"

#define BASEURL @"http://c.m.163.com/nc/"

@implementation NetWorkTool

static NetWorkTool *_instance;

+ (instancetype)sharedNetWorkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                               @"text/json",@"text/javascript",@"text/html",nil];
        
    });
    return _instance;
    
}





















@end
