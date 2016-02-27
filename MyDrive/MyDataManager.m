//
//  MyDataManager.m
//  MyDrive
//
//  Created by 管理员 on 16/2/1.
//  Copyright © 2016年 wmd. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "SelectModel.h"
#import "AnswerModel.h"
#import "SubTestSelectModel.h"
@implementation MyDataManager

+ (NSArray *)getData:(DataType)type
{
    static FMDatabase *database;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (database == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
        
        database = [[FMDatabase alloc] initWithPath:path];
    }
    
    if ([database open]) {
        NSLog(@"open success");
    }else{
        return array;
    }
    
    switch (type) {
        case chapter://章节
        {
            NSString *sql = @"select pid,pname,pcount FROM firstlevel";
            FMResultSet *rs = [database executeQuery:sql];
            while ([rs next]) {
                SelectModel *model = [[SelectModel alloc] init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.pcount = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pcount"]];
                [array addObject:model];
            }
        }
            break;
        case answer://答题数据
        {
            NSString *sql = @"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet *rs = [database executeQuery:sql];
            while ([rs next]) {
                AnswerModel *model = [[AnswerModel alloc] init];
                model.mquestion = [rs stringForColumn:@"mquestion"];
                model.mdesc = [rs stringForColumn:@"mdesc"];
                model.mid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mid"]];
                model.manswer = [rs stringForColumn:@"manswer"];
                model.mimage = [rs stringForColumn:@"mimage"];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.sid = [NSString stringWithFormat:@"%.2f",[rs doubleForColumn:@"sid"]];
                model.sname = [rs stringForColumn:@"sname"];
                model.mtype = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mtype"]];
                [array addObject:model];
            }
        }
            break;
        case subChapter://专项
        {
            NSString *sql = @"select pid,sname,scount,sid,serial FROM secondlevel";
            FMResultSet *rs = [database executeQuery:sql];
            while ([rs next]) {
                SubTestSelectModel *model = [[SubTestSelectModel alloc] init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.sid = [NSString stringWithFormat:@"%.2f",[rs doubleForColumn:@"sid"]];
                model.sname =[rs stringForColumn:@"sname"];
                model.scount = [NSString stringWithFormat:@"%d",[rs intForColumn:@"scount"]];
                model.serial = [NSString stringWithFormat:@"%d",[rs intForColumn:@"serial"]];
                [array addObject:model];
            }
        }
            break;
        default:
            break;
    }
    return array;
}
@end
