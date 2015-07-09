//
//  AddDeviceCell.m
//  RiceCooker
//
//  Created by yi on 15/7/3.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "AddDeviceCell.h"

@implementation AddDeviceCell

+ (id)AddDeviceCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:nil options:nil][0];
}

+ (NSString *)ID
{
    return @"Cell";
}


@end
