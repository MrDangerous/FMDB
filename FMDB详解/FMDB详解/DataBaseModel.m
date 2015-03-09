//
//  DataBaseModel.m
//  FMDB详解
//
//  Created by XWQ on 15/3/9.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import "DataBaseModel.h"
#import "AppUtil.h"

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


@end
