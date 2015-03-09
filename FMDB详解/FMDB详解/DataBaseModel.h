//
//  DataBaseModel.h
//  FMDB详解
//
//  Created by XWQ on 15/3/9.
//  Copyright (c) 2015年 _Name.im_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseModel : NSObject
+(DataBaseModel *)shardDataBaseModle;
-(void)moveDataBaseToLibrary;
-(void)insert;
-(void)selsect;
-(void)delete;
-(void)multithread;
@end
