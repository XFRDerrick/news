//
//  NetWorkTool.h
//  News
//
//  Created by 赫腾飞 on 15/11/25.
//  Copyright © 2015年 hetefe. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetWorkTool : AFHTTPSessionManager


+ (instancetype)sharedNetWorkTool;

@end
