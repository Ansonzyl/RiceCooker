//
//  UserInfoCell.m
//  RiceCooker
//
//  Created by yi on 15/7/23.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDm_userInfo:(DM_UserInfo *)dm_userInfo
{
    _dm_userInfo = dm_userInfo;
    [self.recipebBtn setTitle:dm_userInfo.collectrecipe forState:UIControlStateNormal];
    [self.shareBtn setTitle:dm_userInfo.sharedevice forState:UIControlStateNormal];
    [self.linkBtn setTitle:dm_userInfo.bindsevice forState:UIControlStateNormal];
}

@end
