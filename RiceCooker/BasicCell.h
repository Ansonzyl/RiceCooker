//
//  BasicCell.h
//  RiceCooker
//
//  Created by yi on 15/7/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_MyDevices.h"
@interface BasicCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (nonatomic, strong) DM_MyDevices *device;
- (void)setDevice:(DM_MyDevices *)device;
+ (id)basicCell;
+ (NSString *)cellID;

@end
