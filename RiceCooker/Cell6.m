//
//  Cell6.m
//  RiceCooker
//
//  Created by yi on 15/11/1.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell6.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation Cell6

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
        [self setLabel];
    }
    return self;
}

- (void)setLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 200, 24)];
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textColor = UIColorFromRGB(0x848484);
    [self.contentView addSubview:_titleLabel];
    CGRect frame = CGRectMake(kWidth - 90 , 0, 50, 26);
    _countLabel = [[UILabel alloc] initWithFrame:frame];
    _countLabel.textColor = UIColorFromRGB(0x848484);
    _countLabel.font = _titleLabel.font;
    [self.contentView addSubview:_countLabel];
    frame.origin.x = kWidth - 67;
    _priceLabel = [[UILabel alloc] initWithFrame:frame];
    _priceLabel.textColor = UIColorFromRGB(0x40c8c4);
    _priceLabel.font = _titleLabel.font;
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
}

@end
