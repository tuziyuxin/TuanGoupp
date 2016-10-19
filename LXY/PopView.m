//
//  PopView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "PopView.h"


@interface PopView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTV;
@property (weak, nonatomic) IBOutlet UITableView *rightTV;

@end
@implementation PopView
{
    NSInteger _selectedIndex;
    NSArray* _subArray;//subArray可能是空
}

+(instancetype)creatPopView
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:self options:nil] firstObject];
}



#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTV) {
        return [self.dataSource numberOfRowsInLeftTableViewOfView:self];
    }else
    {
        return [_subArray count];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTV) {
        static NSString* leftCellName=@"left cell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:leftCellName];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellName];
        }
        cell.textLabel.text=[self.dataSource titleForRowAtLeft:indexPath.row View:self];
        cell.imageView.image=[UIImage imageNamed:[self.dataSource pathForImageAtLeft:indexPath.row View:self]];
        
        if ([self.dataSource subDataOfRightViewAtIndex:indexPath.row View:self]) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else
        {
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
        return cell;
    }else
    {
        static NSString* rightCellName=@"right cell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:rightCellName];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightCellName];
        }
        if (_subArray) {
            cell.textLabel.text=[self.dataSource titleForRowAtRight:indexPath.row WithLeft:_selectedIndex View:self];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegata

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTV) {
        
        _selectedIndex=indexPath.row;
        _subArray=[self.dataSource subDataOfRightViewAtIndex:indexPath.row View:self];
        
        [self.rightTV reloadData];
    }
}







@end
