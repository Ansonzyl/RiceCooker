//
//  AffirmViewController.h
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_UserMessage.h"
@interface AffirmViewController : UITableViewController
@property (nonatomic, strong) DM_UserMessage *userMsg;
@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, copy) NSString *totolPrice;
@property (nonatomic, assign) int weight;
@property (nonatomic, strong) NSMutableArray *affirmArray;
@end
