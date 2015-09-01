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
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *finishTime;
@property (weak, nonatomic) IBOutlet UILabel *moduleLable;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;



@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) DM_ERiceCell *riceCell;
- (void)setRiceCell:(DM_ERiceCell *)riceCell;
@property (nonatomic, strong) DM_EVegetable *device;
- (void)setDevice:(DM_EVegetable *)device;
+ (NSString *)cellID;
+ (id)ericeCell;

@end
