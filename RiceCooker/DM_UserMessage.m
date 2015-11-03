//
//  DM_UserMessage.m
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "DM_UserMessage.h"

@implementation DM_UserMessage

+ (DM_UserMessage *)userMessageWithDict:(NSDictionary *)dict
{
    DM_UserMessage *msg = [[self alloc] init];
    [msg setValuesForKeysWithDictionary:dict];
    
    return msg;
}



- (NSDictionary *)encodedItem
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.userAddress, @"userAddress",
            self.userName, @"userName",
            self.userPhone , @"userPhone",
            nil];
}


@end
