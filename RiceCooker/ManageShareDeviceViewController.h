//
//  ManageShareDeviceViewController.h
//  RiceCooker
//
//  Created by yi on 15/7/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_ShareDevices.h"
@interface ManageShareDeviceViewController : UITableViewController
@property (nonatomic, strong) NSArray *devices;
@property (nonatomic, strong) DM_ShareDevices *shareDevice;
@end
