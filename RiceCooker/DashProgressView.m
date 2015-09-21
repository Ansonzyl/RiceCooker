//
//  DashProgressView.m
//  RiceCooker
//
//  Created by yi on 15/9/7.
//  Copyright (c) 2015年 yi. All rights reserved.
//

#import "DashProgressView.h"

@implementation DashProgressView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        self.clearsContextBeforeDrawing = YES;
        _percent = 0;
    }
    
    return  self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置线条颜色
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.4);
    // 设置线宽
    CGContextSetLineWidth(ctx, 9.0);
    // 设置点线模式
    CGFloat lengths[] = {1, 4};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    int outerDiameter = MIN(viewSize.width, viewSize.height);
    double outerRadius = outerDiameter / 2.0 - 10;
    
    CGContextBeginPath(ctx);
    double startAngle =  - M_PI_2;
    double endAngle =  2 * M_PI - M_PI_2;
    
    CGContextAddArc(ctx, center.x, center.y, outerRadius, startAngle, endAngle, 0);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    double start =  - M_PI_2;
    double end =  2 * M_PI *_percent - M_PI_2;
    
    CGContextAddArc(ctx, center.x, center.y, outerRadius, start, end, 0);
    CGContextStrokePath(ctx);

}


@end
