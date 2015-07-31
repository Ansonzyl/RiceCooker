//
//  DM_ShareDevices.m
//  RCooker
//
//  Created by yi on 15-5-31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DM_ShareDevices.h"

@implementation DM_ShareDevices
+ (id)shareDeviceWithDic:(NSDictionary *)dic
{
    DM_ShareDevices *shareDevice = [[DM_ShareDevices alloc] init];
    [shareDevice setValuesForKeysWithDictionary:dic];
    return shareDevice;
}

@end
