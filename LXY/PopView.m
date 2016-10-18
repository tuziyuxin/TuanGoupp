//
//  PopView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "PopView.h"
#import "CategoryModel.h"
@interface PopView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTV;
@property (weak, nonatomic) IBOutlet UITableView *rightTV;

@end
@implementation PopView
{
    CategoryModel* _selectedModel;
}

+(instancetype)creatPopView
{
    return  [[[NSBundle mainBundle] loadNibNamed:@"PopView" owner:self options:nil] firstObject];
}



#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_leftTV) {
        return [_totalArray count];
    }else
    {
        return [_selectedModel.subClass count];
        //return [_totalArray count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTV) {
        static NSString* leftCellName=@"left cell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:leftCellName];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCellName];
        }
        CategoryModel* modelForCell=_totalArray[indexPath.row];
        cell.textLabel.text=modelForCell.name;
        cell.imageView.image=[UIImage imageNamed:modelForCell.smallIcon];
        if (modelForCell.subClass) {
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
        if (_selectedModel.subClass) {
            NSArray* array=_selectedModel.subClass;
            cell.textLabel.text=array[indexPath.row];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegata

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTV) {
        _selectedModel=_totalArray[indexPath.row];//当其判断为需要重新载入时，需要reloadData
        [self.rightTV reloadData];
    }
}







@end
