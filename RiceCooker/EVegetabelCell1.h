//
//  EVegetabelCell1.h
//  RiceCooker
//
//  Created by yi on 15/7/31.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_EVegetable.h"
@interface EVegetabelCell1 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *finishTime;
@property (strong, nonatomic) IBOutlet UILabel *moduleLable;
@property (strong, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *degreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *settimeLabel;

@property (strong, nonatomic) IBOutlet UILabel *device;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIImageView *degreeImageView;
@property (strong, nonatomic) IBOutlet UIImageView *materialImageView;
@property (strong, nonatomic) IBOutlet UIImageView *weightImageView;
@property (strong, nonatomic) IBOutlet UIImageView *setTimeImageView;

@property (nonatomic, strong) DM_EVegetable *vegetable;
@property (nonatomic, strong) DM_EVegetable *vegetable1;
@property (nonatomic, strong) DM_EVegetable *vegetable2;
@property (nonatomic, strong) DM_EVegetable *vegetable3;

+ (NSString *)cellID;
+ (id)eVegetableCell;
- (void)setVegetable:(DM_EVegetable *)vegetable;

@end
