//
//  Cell3.m
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell3.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@implementation Cell3

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = UIColorFromRGB(0xf3f3f3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = UIColorFromRGB(0xf3f3f3);
    CGFloat size = 18*kRate;
    CGFloat kHeight = 15 *kRate;
    self.imageView.bounds = CGRectMake(0, 0, size, size);
    self.imageView.frame = CGRectMake(15*kRate, kHeight, size, size);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.textLabel.font = [UIFont systemFontOfSize:13*kRate];
    
    CGRect tmpFrmae = self.textLabel.frame;
    tmpFrmae.origin.y = kHeight;
    tmpFrmae.origin.x = 39*kRate;
    self.textLabel.frame = tmpFrmae;
}



@end
