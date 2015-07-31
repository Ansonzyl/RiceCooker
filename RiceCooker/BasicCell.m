//
//  BasicCell.m
//  RiceCooker
//
//  Created by yi on 15/7/27.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "BasicCell.h"

@implementation BasicCell

+ (id)basicCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil][1];
}

+ (NSString *)cellID
{
    return @"basicCell";
}

- (void)setDevice:(DM_MyDevices *)device
{
    _device = device;
    self.titleLabel.text = device.devicename;
    self.detailLabel.text = device.state;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            ((UIView *)[subView.subviews firstObject]).backgroundColor = UIColorFromRGB(0xcb5050);
        }
    }
}




@end
