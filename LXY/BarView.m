//
//  BarView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "BarView.h"

@implementation BarView

+(instancetype)createItem
{
    return [[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil] lastObject];
}

@end
