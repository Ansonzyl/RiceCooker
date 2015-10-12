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
    
    [cell setTime:cell.remaintime withSetTime:cell.settime];
    return cell;
}


- (void)setTime:(NSString *)remainTime withSetTime:(NSString *)setTime
{
    
   
    if ([_device isEqualToString:@"e饭宝"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMddHH:mm"];
        NSDate *finish = [formatter dateFromString:_finishtime];
        NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
        self.remianTime = [finish timeIntervalSinceDate:now];
        

    }else
    {
        NSInteger time = [self.remaintime doubleValue];
        self.remianTime = time/4 * 3600 + time%2 + time/2%2 * 60;
        self.settime = [NSString stringWithFormat:@"%@min", self.settime];
        self.pnumberweight = [NSString stringWithFormat:@"%@g", self.pnumberweight];
    }
    if (_remianTime < 0) {
        _remianTime = 0;
    }

    _settingTime = [setTime integerValue] * 60;
    if ([self.module isEqualToString:@"待机中"]) {
        _remianTime = _settingTime;
    }

    

    NSString *str = [_finishtime substringFromIndex:4];
    _appointTime = [NSMutableString stringWithFormat:@"%@完成", str];
}


@end
