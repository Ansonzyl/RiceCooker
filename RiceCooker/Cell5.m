//
//  Cell5.m
//  RiceCooker
//
//  Created by yi on 15/10/31.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell5.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#import "LineView.h"

@implementation Cell5

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

- (void) setLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(53, 0, 100, 35)];
    label.text = @"总重量";
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = UIColorFromRGB(0x848484);
    [self.contentView addSubview:label];
    
    CGRect frame = CGRectMake(kWidth - 150 , 0, 100, 35);
    _weightLabel = [[UILabel alloc] initWithFrame:frame];
    _weightLabel.textColor = UIColorFromRGB(0x848484);
    [self.contentView addSubview:_weightLabel];
    UILabel *all = [[UILabel alloc] init];
    frame.origin.x += 60;
    all.frame = frame;
    all.textColor = _weightLabel.textColor;
    all.text = @"总价";
    all.font = label.font;
    [self.contentView addSubview:all];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x - 10, 7, 1, 20)];
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.contentView addSubview:line];
    _weightLabel = [[UILabel alloc] init];
    _weightLabel.font = label.font;
    _weightLabel.textColor = label.textColor;
    frame.origin.x -=  118;
    _weightLabel.frame = frame;
    _weightLabel.textAlignment = NSTextAlignmentRight;
    _weightLabel.frame = frame;
    [self.contentView addSubview:_weightLabel];

    
    _totolLabel = [[UILabel alloc] init];
    _totolLabel.textAlignment = NSTextAlignmentRight;
    frame.origin.x = kWidth - 117;
    _totolLabel.frame = frame;
    _totolLabel.textColor = UIColorFromRGB(0x40c8c4);
    [self.contentView addSubview:_totolLabel];
    
    _totolLabel.font = label.font;
    
}




@end
