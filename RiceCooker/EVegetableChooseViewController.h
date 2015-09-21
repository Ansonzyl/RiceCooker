//
//  EVegetableChooseViewController.h
//  RiceCooker
//
//  Created by yi on 15/9/2.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DM_EVegetable.h"
@interface EVegetableChooseViewController : UIViewController
@property (nonatomic, strong) DM_EVegetable *device;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, copy) NSString *currentButtonName;

@end
