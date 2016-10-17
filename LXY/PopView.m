//
//  PopView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "PopView.h"

@implementation PopView

+(instancetype)creatPopView
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:self options:nil] firstObject];
}
@end
