//
//  DM_UserMessage.h
//  RiceCooker
//
//  Created by yi on 15/10/29.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DM_UserMessage : NSObject
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *userAddress;

@property (nonatomic, assign) BOOL isSeleted;
- (NSDictionary *)encodedItem;
+ (DM_UserMessage *)userMessageWithDict:(NSDictionary *)dict;
@end
