//
//  TestSelectViewController.h
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController

@property(nonatomic,copy)NSString *myTitle;
@property(nonatomic,copy)NSArray *dataArray;
//type=1章节 type＝2 专项
@property(nonatomic,assign) int type;
@end
