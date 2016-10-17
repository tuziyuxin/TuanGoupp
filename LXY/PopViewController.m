//
//  PopViewController.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "PopViewController.h"
#import "PopView.h"

@implementation PopViewController

-(void)loadView
{
    [super loadView];
}

-(void)viewDidLoad
{
 //   [super viewDidLoad];
    PopView* view=[PopView creatPopView];
    [self.view addSubview:view];
}
@end
