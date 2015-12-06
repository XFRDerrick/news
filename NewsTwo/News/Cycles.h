//
//  Cycles.h
//  
//
//  Created by 赫腾飞 on 15/11/26.
//
//

#import <Foundation/Foundation.h>

typedef void(^FinishedBlock)(NSArray *cycleList);
@interface Cycles : NSObject


#pragma mark title
@property (nonatomic, copy) NSString *title;


#pragma mark image
@property (nonatomic, copy) NSString *imgsrc;

/**
 *  类方法创建
 */
+ (void)headlinesWithFinishedBlock:(FinishedBlock)finishedBlock;

@end
