//
//  ReusableViewHeader.m
//  RiceCooker
//
//  Created by yi on 15/11/5.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "ReusableViewHeader.h"

@implementation ReusableViewHeader

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)scanAll:(UIButton *)sender {
    [_delegate clickBtnWithButton:sender withTitle:self.labelText.text];
}
@end
