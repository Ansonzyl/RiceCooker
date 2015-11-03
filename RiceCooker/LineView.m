//
//  LineView.m
//  RiceCooker
//
//  Created by yi on 15/11/1.
//  Copyright © 2015年 yi. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        self.clearsContextBeforeDrawing = YES;
        
    }
    
    return  self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线段顶端形状
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, _lineWidth);
    
    CGContextSetRGBStrokeColor(context, _red, _green, _blue, _alpha);
    CGPoint points[] = {_point1, _point2};
    CGContextStrokeLineSegments(context, points, 2);
    
}


@end
