//
//  AddressCell.m
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "AddressCell.h"



@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
}

+ (id)addressCell
{
    AddressCell *cell = [[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:nil options:nil][0];
    cell.userAddress.font = [UIFont systemFontOfSize:11 * kRate];
//    cell.userPhone.font = cell.userAddress.font;
    
    return cell;
}





- (void)setUserMessage:(DM_UserMessage *)userMessage
{
    _userMessage = userMessage;
    _userAddress.text = userMessage.userAddress;
    _userPhone.text = userMessage.userPhone;
    _userName.text = userMessage.userName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = [UIColor whiteColor];
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _select.bounds = CGRectMake(0, 0, 23, 23);
    _select.frame = CGRectMake(16, 17, 23, 23);
    _select.contentMode = UIViewContentModeScaleAspectFit;
}


@end
