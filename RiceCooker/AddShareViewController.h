//
//  AddShareViewController.h
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_ShareDevices.h"
@interface AddShareViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) DM_ShareDevices *shareDevice;


@end
