//
//  MyNavigation.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "MyNavigation.h"

@interface MyNavigation ()

@end

@implementation MyNavigation

- (void)viewDidLoad {
    
//在ViewController中进行所有的bar的先行改造
    [super viewDidLoad];
    
//获取UINavigationBar的新方法
    UINavigationBar * bar=[UINavigationBar appearance];
//设置背景图片，虽然背景图片size和bar的size不太一样
    [bar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
