//
//  TestSelectViewController.m
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "SelectModel.h"
#import "AnswerViewController.h"
#import "SubTestSelectModel.h"
@interface TestSelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.title = _myTitle;
    [self createTableView];
    
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewStylePlain;
        cell.numberLable.layer.masksToBounds = YES;
        cell.numberLable.layer.cornerRadius = 8;
    }
    if (_type == 1) {
        SelectModel *model = _dataArray[indexPath.row];
        cell.numberLable.text = model.pid;
        cell.titleLable.text = model.pname;
    }else if(_type == 2){
        SubTestSelectModel *model = _dataArray[indexPath.row];
        cell.numberLable.text = model.serial;
        cell.titleLable.text = model.sname;
    }
   
    return  cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AnswerViewController *avc = [[AnswerViewController alloc] init];
   
    if (_type == 1) {
         avc.type = 1;
    }else{
        avc.type = 4;
    }
    
    
    [self.navigationController pushViewController:avc animated:YES];
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
