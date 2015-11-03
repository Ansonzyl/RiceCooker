//
//  Cell4.m
//  RiceCooker
//
//  Created by yi on 15/10/31.
//  Copyright © 2015年 yi. All rights reserved.
//  确认

#import "Cell4.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@implementation Cell4

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
    self.imageView.bounds = CGRectMake(0, 0, 19, 19);
    self.imageView.frame = CGRectMake(17, 11, 19, 19);
    //    self.textLabel.bounds = CGRectMake(0, 0, 100, 19);
    self.textLabel.frame = CGRectMake(54, 13, 100, 19);
    self.textLabel.font = [UIFont systemFontOfSize:11];

    self.detailTextLabel.textColor = UIColorFromRGB(0xff5602);
    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
    self.textLabel.text = @"期望送达时间";
    
    
//    self.detailTextLabel.text = @"未选择时间";

}


//- (void)setImageAndLabel
//{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 12, 19, 19)];
////    self.imageView.frame = CGRectMake(17, 12, 59, 58);
//    
////    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(54, 13, 100, 19)];
////    self.textLabel.frame = CGRectMake(54, 13, 100, 58);
//    label.font = [UIFont systemFontOfSize:11];
//    self.detailTextLabel.frame = CGRectMake(CGRectGetWidth(self.frame)-70*kRate, 13, 100, 19);
//    self.detailTextLabel.textColor = UIColorFromRGB(0xff5602);
//    self.detailTextLabel.font = [UIFont systemFontOfSize:11];
//    label.text = @"期望送达时间";
//    imageView.image = [UIImage imageNamed:@"icon-期望送达时间.png"];
//    self.detailTextLabel.text = @"未选择时间";
//    [self.contentView addSubview:imageView];
//    [self.contentView addSubview:label];
//}



@end
