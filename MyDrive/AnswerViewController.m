//
//  AnswerViewController.m
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
#import "QuestionCollectManager.h"
@interface AnswerViewController ()<SheetViewDelegate,UIAlertViewDelegate>
{
    AnswerScrollView *_answerScrollView;
    SelectModelView *modelView;
    SheetView *_sheetView;
    NSTimer *_timer;
    UILabel *_timerlable;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createModelView];
    [self createData];
    [self.view addSubview:_answerScrollView];
    
    
    [self createSheetView];
}

- (void)createData
{
    if (_type == 1) {//章节练习
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        NSArray *array = [MyDataManager getData:answer];
        for (int i = 0; i < array.count; i++) {
            
            AnswerModel *model = array[i];
            if ([model.pid intValue] == _number +1) {
                [arr addObject:model];
            }
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:arr];
    }else if (_type == 2){
         _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:[MyDataManager getData:answer]];
    }else if(_type == 3){
        NSMutableArray *temArr = [[NSMutableArray alloc] init];
        NSArray *array = [MyDataManager getData:answer];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        [temArr addObjectsFromArray:array];
        
        for (int i = 0; i < temArr.count;) {
            int index = arc4random()%(temArr.count);
            [dataArray addObject:temArr[index]];
            [temArr removeObjectAtIndex:index];
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:dataArray];
    }else if (_type == 4){
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        NSArray *array = [MyDataManager getData:answer];
        for (int i = 0; i < array.count; i++) {
            
            AnswerModel *model = array[i];
             [arr addObject:model];
            
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:arr];
    }else if (_type == 5){
        NSMutableArray *temArr = [[NSMutableArray alloc] init];
        NSArray *array = [MyDataManager getData:answer];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        [temArr addObjectsFromArray:array];
        
        for (int i = 0; i < 100;i++) {
            int index = arc4random()%(temArr.count);
            [dataArray addObject:temArr[index]];
            [temArr removeObjectAtIndex:index];
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:dataArray];
        
        [self createNavBtn];
    }
    
    if (_type == 7) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSArray *array = [MyDataManager getData:answer];
        
        NSArray *wrongArray = [QuestionCollectManager getWronQuesstion];
        for (AnswerModel *model in array) {
            for (NSString *num in wrongArray) {
                if ([num isEqualToString:model.mid]) {
                    [arr addObject:model];
                }
            }
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:arr];
    }
    if (_type == 8) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSArray *array = [MyDataManager getData:answer];
        
        NSArray *wrongArray = [QuestionCollectManager getCollectQuesstion];
        for (AnswerModel *model in array) {
            for (NSString *num in wrongArray) {
                if ([num isEqualToString:model.mid]) {
                    [arr addObject:model];
                }
            }
        }
        _answerScrollView = [[AnswerScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width ,self.view.frame.size.height-64-60) withDataArray:arr];
    }
    if (_type !=5&&_type!=6) {
        [self createToolBar];
    }else{
        [self createTestToolBar];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
        _timerlable= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
        _timerlable.text= @"60:00";
        _timerlable.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = _timerlable;
    }
    
   
}

- (void)runTime
{
    static int Time = 3600;
    Time--;
    _timerlable.text = [NSString stringWithFormat:@"%d:%d",Time/60,Time%60];
    
}
- (void)createNavBtn
{
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] init];
    itemLeft.title = @"返回";
    [itemLeft setTarget:self];
    [itemLeft setAction:@selector(clickNavReturn)];
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] init];
    itemRight.title = @"交卷";
    [itemRight setTarget:self];
    [itemRight setAction:@selector(clickRightItem)];
    
    self.navigationItem.rightBarButtonItem = itemRight;
    
    
}

- (void)clickRightItem
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要离开考试吗？" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"我要交卷", nil];
    [alert show];
}
- (void)clickNavReturn
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要离开考试吗？" delegate:self cancelButtonTitle:@"不，谢谢" otherButtonTitles:@"我要离开", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
        {
            int sorce = 0;
            //做交卷处理
            NSArray * myAnswerArray = _answerScrollView.hadAnswerArray;
            NSArray * answerArray = _answerScrollView.dataArray;
            for (int i = 0; i < myAnswerArray.count; i++) {
                AnswerModel *model =answerArray[i];
                // 做 题目类型的判断
                NSString *answerStr = model.manswer;
                NSString *myAnswerStr = [NSString stringWithFormat:@"%c",'A'-1+[myAnswerArray[i] intValue]];
                
                if ([answerStr isEqualToString:myAnswerStr]) {
                    sorce++;
                }
                NSLog(@"score:%d",sorce);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)createSheetView
{
    _sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) withSuperView:self.view andQuesCount:(int)_answerScrollView.dataArray.count];
    _sheetView.delegate =self;
    [self.view addSubview:_sheetView];
    
}
#pragma mark - delegate
- (void)SheetViewClick:(int)index
{
    UIScrollView * scroll =_answerScrollView->_scrollview;
    scroll.contentOffset = CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
}
- (void)createModelView
{
    modelView = [[SelectModelView alloc] initWithFrame:self.view.frame addTouch:^(SelectModel model){
        NSLog(@"当前模式：%d",model);
    }];
    [self.view addSubview:modelView];
    modelView.alpha = 0;
 
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
    
}
- (void)modelChange:(UIBarButtonItem *)item
{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha = 1;
    }];
}
- (void)createToolBar
{
    UIView *barCiew = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barCiew.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[[NSString stringWithFormat:@"%zd",_answerScrollView.dataArray.count],@"查看答案",@"收藏本题"];
    for (int i =0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        btn.tag = 301+i;
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barCiew addSubview:btn];
        [barCiew addSubview:label];
    }
    [self.view addSubview:barCiew];
}
- (void)createTestToolBar
{
    UIView *barCiew = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60-64, self.view.frame.size.width, 60)];
    barCiew.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[[NSString stringWithFormat:@"%zd",_answerScrollView.dataArray.count],@"收藏本题"];
    for (int i =0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(self.view.frame.size.width/2*i+self.view.frame.size.width/2/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        btn.tag = 301+i;
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barCiew addSubview:btn];
        [barCiew addSubview:label];
    }
    [self.view addSubview:barCiew];
}
- (void)clickToolBar:(UIButton*)btn
{
    switch (btn.tag) {
        case 301:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView->_backView.alpha = 0.8;
            }];
        }
            break;
        case 302://查看答案
        {
            if (_type !=5&&_type!=6) {
                if ([_answerScrollView.hadAnswerArray[_answerScrollView.currentPage] intValue]!=0) {
                    return;
                }else{
                    AnswerModel *model = [_answerScrollView.dataArray objectAtIndex:_answerScrollView.currentPage];
                    NSString *answer = model.manswer;
                    char an = [answer characterAtIndex:0];
                    [_answerScrollView.hadAnswerArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d",(int)(an-'A'+1)]];
                }
            }
            
        }
            break;
        case 303://收藏本题
        {
            AnswerModel *model = _answerScrollView.dataArray[_answerScrollView.currentPage];
            [QuestionCollectManager addCollectQuestion:[model.mid intValue]];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
