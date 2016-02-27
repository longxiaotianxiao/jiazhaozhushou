//
//  MyDataManager.h
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    chapter,// 章节练习数据
    answer,//答题数据
    subChapter,//专项练习
    
}DataType;
@interface MyDataManager : NSObject

+ (NSArray *)getData:(DataType)type;
@end
