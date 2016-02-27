//
//  AnswerViewController.h
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController

@property(nonatomic,assign)int number;
@property(nonatomic,copy)NSString *subStrNumber;
//type= 1章节 type = 2顺序练习 type=3随机练习 type=4 专项练习 type = 5模拟考试（全真）type=6先考未答 type＝7 我的错题 type=8 我的收藏
@property(nonatomic,assign)int type;

@end
