//
//  AddDeviceCell.h
//  RiceCooker
//
//  Created by yi on 15/7/3.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDeviceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UILabel *myLebel;
+ (id)AddDeviceCell;
+ (NSString *)ID;
@end
