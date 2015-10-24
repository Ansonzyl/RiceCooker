//
//  DM_UIConten.h
//  RiceCooker
//
//  Created by yi on 15/10/13.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DM_UIConten : UIView

- (UILabel *)initializeLabelWithFrame:(CGRect)frame  withText:(NSString *)text withSize:(CGFloat)size;

- (UIImageView *)initializeImageWithFrame:(CGRect)frame withImageName:(NSString *)name withHightlightImage:(NSString *)hightlight;

- (UITextField *)initializeTextFieldWithFrame:(CGRect)frame withFont:(CGFloat)size withtextAlignment:(NSTextAlignment)alignment withPlaceholderText:(NSString *)text withColor:(UIColor*)color;
- (UIButton *)setButtonWithFrame:(CGRect)frame  withText:(NSString *)text withFont:(CGFloat)size;
@end
