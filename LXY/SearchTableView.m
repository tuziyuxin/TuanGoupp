//
//  SearchTableView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/18.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "SearchTableView.h"
#import "Cities.h"
#import "Constant.h"

@implementation SearchTableView
{
    NSArray<Cities *>* _selectedArray;
    NSArray<Cities *>* _totalArray;
}

#pragma mark - init
//当有xib时，利用的就是此方法进行初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    
    self.dataSource=self;
    self.delegate=self;
    
    Cities* city=[[Cities alloc] init];
    _totalArray=[city loadPlist];
    return self;
}

#pragma mark - string related
-(void)setString:(NSString *)string
{
    _string=string;
    _selectedArray=[self findTheTrueString:string];

    [self reloadData];//老是忘记reloadData
}

//找到里面包含的string，本来打算每次找的时候少找一点，后来发现需要分情况的太多（需要保存上一次的_selectedArray），就放弃了
-(NSMutableArray*)findTheTrueString:(NSString*)string
{
    NSMutableArray* array=[[NSMutableArray alloc] init];
    for(Cities* city in _totalArray)
    {
        if ([city.name hasPrefix:string]||[city.pinYin hasPrefix:string]||[city.pinYinHead hasPrefix:string]) {
            [array addObject:city];
        }
    }
    return array;
}




#pragma mark -UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:City_Change_Notifaction object:nil userInfo:@{city_name:[_selectedArray[indexPath.row] name]}];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectedArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellName=@"My cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text=[_selectedArray[indexPath.row] name];
    return cell;
}
















@end
