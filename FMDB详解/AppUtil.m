//
//  AppUtil.m
//  DataBase
//
//  Created by a a a a a on 13-9-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil
+(NSString *)getAppPath
{
    return [NSString stringWithFormat:@"%@/",[[NSBundle mainBundle]resourcePath]];;
}
+(NSString *)getCachesPath
{
    return [NSString stringWithFormat:@"%@/Library/Caches/",NSHomeDirectory()];
}

@end
