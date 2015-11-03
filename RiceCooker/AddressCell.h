//
//  AddressCell.h
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_UserMessage.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414
@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;
@property (weak, nonatomic) IBOutlet UIImageView *select;

@property (nonatomic, strong) DM_UserMessage *userMessage;

- (void)setUserMessage:(DM_UserMessage *)userMessage;

+ (id)addressCell;

@end
