//
//  MyKitchenViewController.h
//  RiceCooker
//
//  Created by yi on 15-6-9.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyKitchenViewController : UIViewController
@property (nonatomic, copy) NSString *phoneNumber;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addDevice:(id)sender;



@end
