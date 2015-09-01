//
//  MyViewController.h
//  RiceCooker
//
//  Created by yi on 15/8/30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_EVegetable.h"
@interface MyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
- (id)initWithDevice:(DM_EVegetable *)device;
- (IBAction)back:(id)sender;


@end
