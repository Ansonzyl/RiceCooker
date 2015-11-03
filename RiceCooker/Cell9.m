//
//  Cell9.m
//  RiceCooker
//
//  Created by yi on 15/11/2.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell9.h"

@implementation Cell9

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
    self.imageView.bounds = CGRectMake(0, 0, 26, 26);
    self.imageView.frame = CGRectMake(17, 9, 26, 26);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.textLabel.textColor = UIColorFromRGB(0x505050);
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.detailTextLabel.textColor = UIColorFromRGB(0xdddddd);
    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
}


@end
