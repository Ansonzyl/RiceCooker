//
//  DM_ShareDevices.h
//  RCooker
//
//  Created by yi on 15-5-31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DM_ShareDevices : NSObject

@property (nonatomic ,copy) NSString *device;
@property (nonatomic ,copy) NSString *devicename;
@property (nonatomic ,copy) NSString *phonenumber;
@property (nonatomic ,copy) NSString *state;
@property (nonatomic, copy) NSString *sharephonenumber;
@property (nonatomic, copy) NSString *UUID;

+ (id)shareDeviceWithDic:(NSDictionary *)dic;
@end
