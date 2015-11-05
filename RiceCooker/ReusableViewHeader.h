//
//  ReusableViewHeader.h
//  RiceCooker
//
//  Created by yi on 15/11/5.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol reusableDelegate <NSObject>

- (void)clickBtnWithButton:(UIButton *)button withTitle:(NSString *)string;

@end

@interface ReusableViewHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, weak) id <reusableDelegate> delegate;
- (IBAction)scanAll:(UIButton *)sender;

@end
