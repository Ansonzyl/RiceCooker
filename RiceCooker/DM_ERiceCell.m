//
//  DM_ERiceCell.m
//  RCooker
//
//  Created by yi on 15-5-29.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DM_ERiceCell.h"

@implementation DM_ERiceCell
+ (DM_ERiceCell *)eRiceWithDict:(NSDictionary *)dict
{
    DM_ERiceCell *cell = [[self alloc] init];
    [cell setValuesForKeysWithDictionary:dict];
//    [cell finishTime];
    [cell remianTimeWithFinishTime:cell.finishtime withSetTime:cell.settime];
    return cell;
}

- (void)remianTimeWithFinishTime:(NSString *)finishTime withSetTime:(NSString *)setTime
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *finish = [formatter dateFromString:finishTime];
    NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    self.remianTime = [finish timeIntervalSinceDate:now];
    _settingTime = [setTime integerValue] * 60;
    if (_settingTime < _remianTime) {
        _remianTime = _settingTime;
    }
}


@end
