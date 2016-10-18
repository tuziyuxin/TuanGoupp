//
//  SecondViewController.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "SecondViewController.h"
#import "ChangCityViewController.h"
#import "MyNavigation.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//切换城市的按钮点击时
- (IBAction)changCityClick:(UIButton *)sender {
    ChangCityViewController* cityController=[[ChangCityViewController alloc] init];
    cityController.title=@"切换城市";
//done BarButtonItem
    cityController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(comeBack)];
    MyNavigation* mNV=[[MyNavigation alloc] initWithRootViewController:cityController];
//设置呈现模式
    mNV.modalPresentationStyle=UIModalPresentationFormSheet;
    
    [self presentViewController:mNV animated:YES completion:nil];
}

-(void)comeBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
