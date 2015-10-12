//
//  AddDeviceCell.m
//  RiceCooker
//
//  Created by yi on 15/7/3.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceCell.h"
#define kRate [UIScreen mainScreen].bounds.size.width / 414

@implementation AddDeviceCell

+ (id)AddDeviceCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil][0];
}
- (void)awakeFromNib {
    // Initialization code
    _myLebel.font = [UIFont systemFontOfSize:18*kRate];
}


+ (NSString *)ID
{
    return @"Cell";
}


@end
