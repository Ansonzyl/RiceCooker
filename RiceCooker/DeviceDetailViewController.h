//
//  DeviceDetailViewController.h
//  RiceCooker
//
//  Created by yi on 15/7/28.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceDetailViewController : UIViewController
@property (nonatomic, copy) NSString *deviceName;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *deviceState;
@end
