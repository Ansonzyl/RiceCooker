//
//  Cell8.m
//  RiceCooker
//
//  Created by yi on 15/11/2.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell8.h"

@implementation Cell8

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
        self = [[NSBundle mainBundle] loadNibNamed:@"Cell7" owner:nil options:nil][1];
    }
    return self;
}

@end
