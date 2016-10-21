//
//  MyLabel.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/20.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "MyLabel.h"

@implementation MyLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2);
    CGContextStrokePath(context);
}

@end
