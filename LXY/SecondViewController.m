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
#import "Constant.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChanged:) name:City_Change_Notifaction object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//切换城市的按钮点击时,对ChangeCityViewController进行present
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

-(void)cityChanged:(NSNotification *)noti
{
NSLog(@"secondViewController %@",noti.userInfo[city_name]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:City_Change_Notifaction object:nil];
}

@end
