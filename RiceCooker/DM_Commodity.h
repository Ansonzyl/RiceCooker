//
//  DM_Commodity.h
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DM_Commodity : NSObject
@property (nonatomic, copy) NSString *count; // 个数
@property (nonatomic, copy) NSString *priceKey; // 价格
@property (nonatomic, copy) NSString *deletePriceKey; // 原价
@property (nonatomic, copy) NSString *nameKey; // 商品名
@property (nonatomic, copy) NSString *imageKey; // 图片名
@property (nonatomic, assign) BOOL isSelected;
+ (DM_Commodity *)commodityWithDict:(NSDictionary *)dict;

- (NSDictionary *) encodedItem;

@end
