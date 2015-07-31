//
//  EriceCell.m
//  RiceCooker
//
//  Created by yi on 15/7/29.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EriceCell.h"

@implementation EriceCell

+ (id)ericeCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"homeCell" owner:nil options:nil][0];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
