//
//  SwipeableCell.h
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_ShareDevices.h"

@protocol SwipebleCellDelegate <NSObject>

- (void)buttonShareActionForItem:(DM_ShareDevices *)shareDevice;
- (void)buttonManagerActionForItem:(DM_ShareDevices *)shareDevice;
- (void)cellDidOpen:(UITableViewCell *)cell;
- (void)cellDidClose:(UITableViewCell *)cell;


@end


@interface SwipeableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIButton *shareButton;
@property (nonatomic, weak) IBOutlet UIButton *managerButton;
@property (nonatomic, weak) IBOutlet UIView *myContentView;
@property (nonatomic, strong) DM_ShareDevices *shareDevice;
@property (nonatomic, weak) id <SwipebleCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
- (void)setShareDevice:(DM_ShareDevices *)shareDevice;

@end
