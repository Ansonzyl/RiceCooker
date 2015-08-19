//
//  EriceCell.m
//  RiceCooker
//
//  Created by yi on 15/7/29.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "EriceCell.h"

@implementation EriceCell

+(NSString *)cellID
{
    return @"riceCell";
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}


+ (id)ericeCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"homeCell" owner:nil options:nil][0];
}

- (void)setRiceCell:(DM_ERiceCell *)riceCell
{
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    self.progressView.layer.cornerRadius = 6;
    _riceCell = riceCell;
    _stateLabel.text = riceCell.state;
    self.pNumberLabel.text = [NSString stringWithFormat:@"%@人份", riceCell.pnumberweight];
    self.moduleLable.text = riceCell.module;
    self.degreeLabel.text = riceCell.degree;
    self.finishTime.text = [NSString stringWithFormat:@"%@完成", riceCell.finishtime];
    [self.progressView setProgress:riceCell.remianTime/riceCell.settingTime];
}



@end
