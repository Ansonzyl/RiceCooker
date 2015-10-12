//
//  UserInfoCell.h
//  RiceCooker
//
//  Created by yi on 15/7/23.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_UserInfo.h"
@interface UserInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;

@property (strong, nonatomic) IBOutlet UIButton *linkBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *recipebBtn;
@property (nonatomic, strong) DM_UserInfo *dm_userInfo;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
- (void)setDm_userInfo:(DM_UserInfo *)dm_userInfo;

@end
