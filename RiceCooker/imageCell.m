//
//  imageCell.m
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "imageCell.h"

@implementation imageCell
#define kRate [UIScreen mainScreen].bounds.size.width / 414
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.contentView.frame;
    self.imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.imageView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
     self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
