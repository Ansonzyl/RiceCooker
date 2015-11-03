//
//  DM_Commodity.m
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "DM_Commodity.h"

@implementation DM_Commodity

+ (DM_Commodity *)commodityWithDict:(NSDictionary *)dict
{
    DM_Commodity *commodity = [[self alloc] init];
    [commodity setValuesForKeysWithDictionary:dict];
    commodity.isSelected = YES;
    
    return commodity;
}

- (NSDictionary *)encodedItem
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.count, @"count",
            self.priceKey, @"priceKey",
            self.deletePriceKey , @"deletePriceKey",
            self.nameKey, @"nameKey",
            self.imageKey, @"imageKey"
            ,nil];
}

@end
