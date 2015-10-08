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

@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

@property (strong, nonatomic) IBOutlet UIImageView *workingImage;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *refrigerationBtn;
@property (weak, nonatomic) IBOutlet UILabel *cancelreFrigerateLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
- (IBAction)cancelreFrigerating:(id)sender;
- (IBAction)collectingRecipe:(id)sender;

- (id)initWithDevice:(DM_EVegetable *)device;


- (IBAction)back:(id)sender;


@end
