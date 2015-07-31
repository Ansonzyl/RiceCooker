//
//  DM_MyDevices.m
//  RCooker
//
//  Created by yi on 15-5-31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DM_MyDevices.h"

@implementation DM_MyDevices

+ (id)myDeviceWithDic:(NSDictionary *)dic
{
    DM_MyDevices *device = [[self alloc] init];
    [device setValuesForKeysWithDictionary:dic];
    return device;
}

@end
