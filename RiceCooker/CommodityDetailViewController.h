//
//  CommodityDetailViewController.h
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_Commodity.h"
@interface CommodityDetailViewController : UIViewController
@property (nonatomic, assign) int numInShop;
@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, strong) DM_Commodity *commodity;
@property (nonatomic, strong) NSArray *allItem;
@end
