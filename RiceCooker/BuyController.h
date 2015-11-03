//
//  BuyController.h
//  RiceCooker
//
//  Created by yi on 15/11/3.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_UserMessage.h"
@interface BuyController : UIViewController
@property (nonatomic, copy) NSMutableString *totalPrice;
@property (nonatomic, strong) NSMutableArray *affirmArray;
@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, copy) NSString *deliveryTime;
@property (nonatomic, strong) DM_UserMessage *userMsg;
@property (nonatomic, copy) NSString *remarks;
@end
