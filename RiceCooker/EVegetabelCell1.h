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
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *finishTime;
@property (weak, nonatomic) IBOutlet UILabel *moduleLable;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *settimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *device;

@property (weak, nonatomic) IBOutlet UIImageView *degreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *materialImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *setTimeImageView;

@property (nonatomic, strong) DM_EVegetable *vegetable;
@property (nonatomic, strong) DM_EVegetable *vegetable1;
@property (nonatomic, strong) DM_EVegetable *vegetable2;
@property (nonatomic, strong) DM_EVegetable *vegetable3;

+ (NSString *)cellID;
+ (id)eVegetableCell;
- (void)setVegetable:(DM_EVegetable *)vegetable;

@end
