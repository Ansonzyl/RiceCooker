//
//  TitleCell.m
//  RiceCooker
//
//  Created by yi on 15/10/27.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "TitleCell.h"
#import "DM_UIConten.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414

@implementation TitleCell

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
    DM_UIConten *ui = [[DM_UIConten alloc] init];
    _titleLabel = [ui initializeLabelWithFrame:CGRectMake(15*kRate, 10*kRate, 320*kRate, 20*kRate) withText:@"菜名" withSize:16];
    _titleLabel.textColor = UIColorFromRGB(0x505050);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    CGFloat kY = 35 *kRate;
    
    _priceLabel = [ui initializeLabelWithFrame:CGRectMake(18*kRate, kY, 70*kRate, 17*kRate) withText:@"¥" withSize:13];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.textColor = UIColorFromRGB(0xff5a00);
    [self.contentView addSubview:_priceLabel];
    _deleteLabel = [ui initializeLabelWithFrame:CGRectMake(71*kRate, kY, 70*kRate, 17*kRate) withText:@"¥" withSize:11.6f];
    _deleteLabel.textColor = UIColorFromRGB(0x848484);
    _deleteLabel.textAlignment = NSTextAlignmentLeft;
    
       [self.contentView addSubview:_deleteLabel];
    
    _salesVolume = [ui initializeLabelWithFrame:CGRectMake(350*kRate, kY, 70*kRate, 17*kRate) withText:@"销量" withSize:11.6f];
    _salesVolume.textAlignment = NSTextAlignmentLeft;
    _salesVolume.textColor = UIColorFromRGB(0x848484);
    
    [self.contentView addSubview:_salesVolume];
    
}


- (void)setTitleLabel:(NSString *)title priceLabel:(NSString *)price deleteLabel:(NSString *)deletePrice salesLabel:(NSString *)salesVolume
{
    _titleLabel.text = title;
    _priceLabel.text = price;
    _deleteLabel.text = deletePrice;
    _salesVolume.text = [NSString stringWithFormat:@"销量 %@", salesVolume];
    
    NSString *str = _deleteLabel.text;
    //    NSDictionary *attrDict1 = @{ NSStrikethroughStyleAttributeName: @(1),
    //                                 NSUnderlineStyleAttributeName:[NSNumber numberWithInt:NSUnderlineStyleSingle],
    //                                 NSStrikethroughColorAttributeName:UIColorFromRGB(0x848484)};
    NSInteger length = [_deleteLabel.text length];
    if (length != 0) {
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str ];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, length)];
        [_deleteLabel setAttributedText:attributeString];

    }
   
}



@end
