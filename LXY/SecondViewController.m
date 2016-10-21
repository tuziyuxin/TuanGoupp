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
#import "Cities.h"

@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController
{
    NSArray* _totalArray;
    NSArray* _regions;
    NSString* _cityName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据模型
    Cities* city=[[Cities alloc] init];
    _totalArray=[city loadPlist];
    [self updateRegionsByName:@"北京"];
    
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
#pragma mark － UITableView 协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _regions.count;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellName=@"my cell";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text=[_regions[indexPath.row] objectForKey:@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* stringName=[_regions[indexPath.row] objectForKey:@"name"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Region_Change_Notifaction object:nil userInfo:@{region_name:stringName}];
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _cityName?_cityName:@"北京";
}
#pragma mark - 通知
    //当通知到来时，实现此方法
-(void)cityChanged:(NSNotification *)noti
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateRegionsByName:noti.userInfo[city_name]];
    [self.tableView reloadData];
}

-(void)updateRegionsByName:(NSString*)string
{
    for (Cities* city in _totalArray) {
        if ([city.name isEqualToString:string]) {
            _cityName=string;
            _regions=city.regions;
            break;
        }
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:City_Change_Notifaction object:nil];
}











@end
