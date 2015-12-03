//
//  EriceCell.h
//  RiceCooker
//
//  Created by yi on 15/7/29.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_ERiceCell.h"
#import "DM_EVegetable.h"

@protocol ConnectDelegate <NSObject>

- (void)deviceTryToConnect:(NSString *)title;

@end

@interface EriceCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *moduleLable;
@property (nonatomic, strong) UIButton *retryButton;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) id <ConnectDelegate> delegate;
@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, strong) DM_ERiceCell *riceCell;
- (void)setRiceCell:(DM_ERiceCell *)riceCell;
- (void)setDevice:(DM_EVegetable *)device;
+ (NSString *)cellID;
+ (id)ericeCell;

@end
