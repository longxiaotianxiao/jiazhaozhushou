//
//  SelectModelView.h
//  MyDrive
//
//  Created by 管理员 on 16/2/3.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    testModel,
    lookingModel,
}SelectModel;
typedef void (^SelecTouch)(SelectModel model);
@interface SelectModelView : UIView

@property(nonatomic,assign)SelectModel model;
- (SelectModelView *)initWithFrame:(CGRect)frame addTouch:(SelecTouch)touch;
@end
