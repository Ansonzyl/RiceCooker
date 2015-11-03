//
//  AddNewAddressCell.m
//  RiceCooker
//
//  Created by yi on 15/10/30.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "AddNewAddressCell.h"

@implementation AddNewAddressCell

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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        label.center = self.contentView.center;
        label.textColor = UIColorFromRGB(0x40c8c4);
        label.font = [UIFont systemFontOfSize:10.0];
        label.text = @"+ 添加新地址";
        [self addSubview:label];
    }
    return self;
}


//- (void)layoutSubviews
//{
//    self.textLabel.center = self.contentView.center;
//    self.textLabel.textColor = UIColorFromRGB(0x40c8c4);
//    self.textLabel.font = [UIFont systemFontOfSize:10.0];
//}



@end
