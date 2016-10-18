//
//  PopViewController.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "PopViewController.h"
#import "PopView.h"
#import "CategoryModel.h"

@implementation PopViewController

-(void)loadView
{
    [super loadView];
}

-(void)viewDidLoad
{
   [super viewDidLoad];
    
//设置view
    PopView* view=[PopView creatPopView];
    
#warning I do not know why this has a relationship with tableview IN view
    view.autoresizingMask=UIViewAutoresizingNone;
    
    [self.view addSubview:view];
    
//将controller的尺寸设置为view的尺寸
    self.preferredContentSize=CGSizeMake(view.frame.size.width, view.frame.size.height);
    
//初始化模型
    CategoryModel* model=[[CategoryModel alloc] init];
    NSArray* array=[model loadPlist];
    
//将view的数据设置好
    view.totalArray=array;
    
    
}
@end
