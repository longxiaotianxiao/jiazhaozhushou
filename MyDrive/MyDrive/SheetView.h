//
//  SheetView.h
//  MyDrive
//
//  Created by 管理员 on 16/2/3.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate
- (void)SheetViewClick:(int)index;
@end

@interface SheetView : UIView
{
    @public
     UIView *_backView;
}
@property(nonatomic,weak)id<SheetViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuesCount:(int)count;
@end
