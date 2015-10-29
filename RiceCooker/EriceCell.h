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

@interface EriceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *finishTime;
@property (strong, nonatomic) IBOutlet UILabel *moduleLable;
@property (strong, nonatomic)  UILabel *pNumberLabel;
@property (strong, nonatomic)  UILabel *degreeLabel;
@property (strong, nonatomic)  UILabel *stateLabel;
@property (nonatomic, strong) UILabel *deviceLabel;

@property (nonatomic, strong) UIImageView *stateImage;
@property (nonatomic, strong) UIImageView *degreeImage;
@property (nonatomic, strong) UIImageView *pNumberImage;
@property (nonatomic, strong) UIButton *retryButton;

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) DM_ERiceCell *riceCell;
- (void)setRiceCell:(DM_ERiceCell *)riceCell;
@property (nonatomic, strong) DM_EVegetable *device;
- (void)setDevice:(DM_EVegetable *)device;
+ (NSString *)cellID;
+ (id)ericeCell;

@end
