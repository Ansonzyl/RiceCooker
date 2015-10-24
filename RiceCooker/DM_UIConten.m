//
//  DM_UIConten.m
//  RiceCooker
//
//  Created by yi on 15/10/13.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "DM_UIConten.h"
#define kRate [UIScreen mainScreen].bounds.size.width/414

@implementation DM_UIConten
- (UILabel *)initializeLabelWithFrame:(CGRect)frame withText:(NSString *)text withSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size * kRate];
    return label;
}


- (UIImageView *)initializeImageWithFrame:(CGRect)frame withImageName:(NSString *)name withHightlightImage:(NSString *)hightlight
{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:hightlight ofType:@"png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path] highlightedImage:[UIImage imageWithContentsOfFile:path2]];
    imageView.frame = frame;
    
    return imageView;
}

- (UITextField *)initializeTextFieldWithFrame:(CGRect)frame withFont:(CGFloat)size withtextAlignment:(NSTextAlignment)alignment withPlaceholderText:(NSString *)text withColor:(UIColor*)color
{
    UITextField *textLabel = [[UITextField alloc] initWithFrame:frame];
    textLabel.placeholder = text;
    textLabel.textAlignment = alignment;
    textLabel.font = [UIFont systemFontOfSize:size ];
    textLabel.textColor = color;
    return textLabel;

}

- (UIButton *)setButtonWithFrame:(CGRect)frame  withText:(NSString *)text withFont:(CGFloat)size
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    
        [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:size*kRate];
    
    return  button;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
