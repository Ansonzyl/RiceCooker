//
//  Cell2.m
//  RiceCooker
//
//  Created by yi on 15/10/28.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "Cell2.h"
#import "DM_UIConten.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414

@implementation Cell2

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLabelAndImage];
    }
    return self;
}


- (void)setLabelAndImage
{
    DM_UIConten *ui = [[DM_UIConten alloc] init];
    CGFloat size = 18 * kRate;
    CGFloat height = 10 * kRate;
    UIImageView *clock = [ui initializeImageWithFrame:CGRectMake(14*kRate, height, size, size) withImageName:@"icon-烹饪时间" withHightlightImage:nil];
    [self.contentView addSubview:clock];
    UIImageView *pNumber = [ui initializeImageWithFrame:CGRectMake(146*kRate, height, size, size) withImageName:@"icon-人数" withHightlightImage:nil];
    [self.contentView addSubview:pNumber];
    
    _cookTime = [ui initializeLabelWithFrame:CGRectMake(36 *kRate, height, 150*kRate, size) withText:@"烹饪时间:15分钟" withSize:11];
    _cookTime.textColor = UIColorFromRGB(0x505050);
    _cookTime.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_cookTime];
    
    _pNum = [ui initializeLabelWithFrame:CGRectMake(167*kRate, height, 150*kRate, size) withText:@"人数:1人份" withSize:11];
    _pNum.textColor = UIColorFromRGB(0x505050);
    _pNum.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_pNum];
    CGRect frame = CGRectMake(0, 0, 121*kRate, 30*kRate);
    UIButton *collect = [ui setButtonWithFrame:CGRectMake(15*kRate, 42*kRate, 121*kRate, 30*kRate) withText:@"收藏" withFont:11];
    [self setButtonWithButton:collect];

    [self.contentView addSubview:collect];
    UIButton *recipeBtn = [ui setButtonWithFrame:frame withText:@"查看食谱" withFont:11];
    [self setButtonWithButton:recipeBtn];
    recipeBtn.center =  [self makeCenterWithPoint:collect.center];
    [self.contentView addSubview:recipeBtn];
    UIButton *startBtn = [ui setButtonWithFrame:frame withText:@"开始烹饪" withFont:11];
    startBtn.center = [self makeCenterWithPoint:recipeBtn.center];
    [self setButtonWithButton:startBtn];
    [self.contentView addSubview:startBtn];
    
}

- (CGPoint)makeCenterWithPoint:(CGPoint)center
{
    CGPoint point = center;
    point.x += 131*kRate;
    return point;
}


- (UIButton *)setButtonWithButton:(UIButton *)button
{
    UIButton *new = button;
    [new setTitleColor:UIColorFromRGB(0x505050) forState:UIControlStateNormal];
    [new.layer setCornerRadius:2.0f];
    [new.layer setBorderWidth:1.0];
    [new.layer setBorderColor:UIColorFromRGB(0xd6d6d6).CGColor];
    return new;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
