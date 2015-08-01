//
//  DM_EVegetable.h
//  RCooker
//
//  Created by yi on 15-5-30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DM_EVegetable : NSObject

@property (nonatomic, copy) NSString *device; //
@property (nonatomic, copy) NSString *devicename;//
@property (nonatomic, copy) NSString *settime;//
@property (nonatomic, copy) NSString *module;//
@property (nonatomic, copy) NSString *phonenumber;//

@property (nonatomic, copy) NSString *state;//
@property (nonatomic, copy) NSString *degree;//
@property (nonatomic, copy) NSString *pnumberweight;//
@property (nonatomic, copy) NSString *finishtime;//
@property (nonatomic, copy) NSString *UUID;//

@property (nonatomic, assign) NSInteger remianTime;
@property (nonatomic, assign) NSInteger settingTime;
+ (DM_EVegetable *)eVegetableWithDict:(NSDictionary *)dict;
@end
