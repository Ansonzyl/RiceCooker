//
//  TitleCell.h
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *deleteLabel;
@property (nonatomic, strong) UILabel *salesVolume;

- (void)setTitleLabel:(NSString *)title priceLabel:(NSString *)price deleteLabel:(NSString *)deletePrice salesLabel:(NSString *)salesVolume;

@end
