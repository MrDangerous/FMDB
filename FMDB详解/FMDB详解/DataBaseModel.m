//
//  DataBaseModel.m
//  FMDB详解
//
//  Created by XWQ on 15/3/9.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import "DataBaseModel.h"
#import "AppUtil.h"
#import "FMDB.h"
@implementation DataBaseModel
+(DataBaseModel *)shardDataBaseModle
{
    static DataBaseModel *dataBaseModel = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataBaseModel = [[DataBaseModel alloc]init];
    });
    
    return dataBaseModel;
}
-(void)moveDataBaseToLibrary
{
    NSString *atPath = [NSString stringWithFormat:@"%@Demo.db",[AppUtil getAppPath]];
    NSString *toPath = [NSString stringWithFormat:@"%@Demo.db",[AppUtil getCachesPath]];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    [fileManger copyItemAtPath:atPath toPath:toPath error:nil];
}

-(void)insert
{
    FMDatabase *database = [[FMDatabase alloc]initWithPath:[NSString stringWithFormat:@"%@Demo.db",[AppUtil getCachesPath]]];
    if (![database open]) {
        return;
    }
    [database executeUpdate:@"insert into User(UserName,UserPassword) values('XWQ','1111')"];
    [database close];
}
-(void)selsect
{
    FMDatabase *dataBase = [[FMDatabase alloc]initWithPath:[NSString stringWithFormat:@"%@Demo.db",[AppUtil getCachesPath]]];
    if(![dataBase open])
    {
        return;
    }
    FMResultSet *rs= [dataBase executeQuery:@"select *from User "];
    //遍历结果集
    while([rs next])
    {
        //建议用intForColumn  stringForColumnIndex:容易出现错误
        //  int userId=[rs intForColumn:@"UserId"];
        NSString *userName = [rs stringForColumnIndex:0];
        NSString *userPassword = [rs stringForColumn:@"UserPassword"];
        NSLog(@"name=%@ password=%@",userName,userPassword);
    }
    
    [dataBase close];


}
-(void)delete
{
    FMDatabase *dataBase = [[FMDatabase alloc]initWithPath:[NSString stringWithFormat:@"%@Demo.db",[AppUtil getCachesPath]]];
    if(![dataBase open])
    {
        return;
    }
    [dataBase executeUpdate:@"delete from User"];
    [dataBase close];
}
-(void)multithread
{
    FMDatabaseQueue * queue =  [[FMDatabaseQueue alloc]initWithPath:[NSString stringWithFormat:@"%@Demo.db",[AppUtil getCachesPath]]];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    dispatch_async(q1, ^{
        for (int i = 0; i < 100; ++i) {
            [queue inDatabase:^(FMDatabase *db) {
                NSString * sql = @"insert into User (UserName, UserPassword) values(?, ?) ";
                NSString * name = [NSString stringWithFormat:@"queue1 %d", i];
                [db executeUpdate:sql, name, @"Dangerous"];
               
            }];
        }
    });
    
    dispatch_async(q2, ^{
        for (int i = 0; i < 100; ++i) {
            [queue inDatabase:^(FMDatabase *db) {
                NSString * sql = @"insert into User (UserName, UserPassword) values(?, ?) ";
                NSString * name = [NSString stringWithFormat:@"queue2 %d", i];
               [db executeUpdate:sql, name, @"Dangerous"];
                
            }];
        }
    });

}
@end
