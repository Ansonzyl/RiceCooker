//
//  DM_EVegetable.m
//  RCooker
//
//  Created by yi on 15-5-30.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DM_EVegetable.h"

@implementation DM_EVegetable
+ (DM_EVegetable *)eVegetableWithDict:(NSDictionary *)dict
{
    DM_EVegetable *cell = [[self alloc] init];
    [cell setValuesForKeysWithDictionary:dict];

    [cell remianTimeWithFinishTime:cell.finishtime withSetTime:cell.settime];
    return cell;
}

//- (void)finishTime
//{
//    NSTimeInterval remain = [_remaintime intValue]*60;
//    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:remain];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm"];
//    self.finishtime = [formatter stringFromDate:date];
//    
//}

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
    _remianTime = _settingTime - _remianTime;
}


@end
