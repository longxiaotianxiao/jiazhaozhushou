//
//  Tools.h
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

+ (NSArray *)getAnswerWithString:(NSString *)str;

+ (CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;
@end
