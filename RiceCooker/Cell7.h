//
//  Cell7.h
//  RiceCooker
//
//  Created by yi on 15/11/1.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell7 : UITableViewCell
@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UILabel *discount;
@property (nonatomic, strong) UILabel *packingFee;
@property (nonatomic, strong) UILabel *commodityPrice;
+ (id)initializeWithBundle;
@end
