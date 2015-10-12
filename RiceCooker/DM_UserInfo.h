//
//  DM_UserInfo.h
//  RiceCooker
//
//  Created by yi on 15/7/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DM_UserInfo : NSObject
@property (nonatomic, copy)NSString *collectrecipe;
@property (nonatomic, copy)NSString *bindsevice;
@property (nonatomic, copy)NSString *sharedevice;
+ (id)userInfoWithDic:(NSDictionary *)dic;
@end
