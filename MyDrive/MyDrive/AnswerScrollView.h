//
//  AnswerScrollView.h
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
{
    @public
    UIScrollView *_scrollview;
}
- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray*)array;
@property(nonatomic,assign,readonly)int currentPage;
@property(nonatomic,strong)NSMutableArray *hadAnswerArray;
@property(nonatomic,strong)NSArray *dataArray;

@end
