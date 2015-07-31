//
//  DM_UserInfo.m
//  RiceCooker
//
//  Created by yi on 15/7/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DM_UserInfo.h"

@implementation DM_UserInfo
+ (id)userInfoWithDic:(NSDictionary *)dic
{
    DM_UserInfo *dm_userInfo = [[self alloc] init];
    [dm_userInfo setValuesForKeysWithDictionary:dic];
    return dm_userInfo;
}
@end
