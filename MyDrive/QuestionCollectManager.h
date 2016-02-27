//
//  QuestionCollectManager.h
//  MyDrive
//
//  Created by 管理员 on 16/2/12.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollectManager : NSObject

+ (NSArray *)getWronQuesstion;
+ (void)addWrongQuestion:(int)mid;
+ (void)removeWrongQuestion:(int)mid;

+ (NSArray *)getCollectQuesstion;
+ (void)addCollectQuestion:(int)mid;
+ (void)removeCollectQuestion:(int)mid;

+ (int)getMySorce;
+ (void)setMySorce:(int)sorce;
@end
