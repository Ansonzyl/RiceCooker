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
    
    
    [cell setTime:cell.remaintime withSetTime:cell.settime];
    return cell;
}

- (void)setTime:(NSString *)remainTime withSetTime:(NSString *)setTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMddHH:mm"];
    NSDate *finish = [formatter dateFromString:_finishtime];
    NSDate *now = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    self.remianTime = [finish timeIntervalSinceDate:now];
    
    NSString *str = [_finishtime substringFromIndex:4];
    _appointTime = [NSMutableString stringWithFormat:@"%@完成", str];
    
    self.remianTime = [self.remaintime doubleValue];
    self.settingTime = [self.settime doubleValue] * 60;
    if (_settingTime < _remianTime) {
        _remianTime = _settingTime;
    }
    _remianTime = _settingTime - _remianTime;
}


@end
