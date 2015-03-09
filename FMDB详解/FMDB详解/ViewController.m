//
//  ViewController.m
//  FMDB详解
//
//  Created by XWQ on 15/3/5.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "AppUtil.h"
#import "User.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSString *atPath = [[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"db"];

    
    NSLog(@"---%@",atPath);
    FMDatabase *dataBase = [[FMDatabase alloc]initWithPath:atPath];
    if(![dataBase open])
    {
        NSLog(@"打开失败");
        return;
    }
    
   
    
    
//    FMResultSet *rs= [dataBase executeQuery:@"select *from User "];
//    //遍历结果集
//    while([rs next])
//    {
//        NSString *userName = [rs stringForColumn:@"UserName"];
//        NSString *userPassword = [rs stringForColumn:@"UserPassword"];
//        NSLog(@"name=%@ password=%@",userName,userPassword);
//    }

    
    if ([dataBase open]) {
        NSString * sql = @"delete from User where UserName = 'LT' ";
        [dataBase executeUpdate:sql];
        
        FMResultSet *rs= [dataBase executeQuery:@"select *from User"];
        //遍历结果集
        while([rs next])
        {
            NSString *userName = [rs stringForColumn:@"UserName"];
            NSString *userPassword = [rs stringForColumn:@"UserPassword"];
            NSLog(@"name=%@ password=%@",userName,userPassword);
        }

    }
   
   
    
    [dataBase close];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
