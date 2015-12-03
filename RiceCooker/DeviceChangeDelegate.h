//
//  DeviceChangeDelegate.h
//  RiceCooker
//
//  Created by yi on 15/9/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DM_EVegetable.h"
@protocol DeviceChangeDelegate <NSObject>
- (void)changeDevice:(DM_EVegetable *)device withIndex:(NSInteger)index;
@end
