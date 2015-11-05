//
//  CollectionViewController.h
//  RiceCooker
//
//  Created by yi on 15/10/26.
//  Copyright © 2015年 yi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, copy) NSString *type;
@end
