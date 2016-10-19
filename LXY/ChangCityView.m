//
//  ChangCityView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "ChangCityView.h"

#import "SearchTableView.h"
#import "Constant.h"
@interface ChangCityView()

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet SearchTableView *tableView;

@end

@implementation ChangCityView

//初始化进行view的create

+(instancetype)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ChangCityView" owner:nil options:nil] firstObject];
}



-(void)setSearchBar:(UISearchBar *)searchBar
{
    _searchBar=searchBar;
}
#pragma mark -UISearchBarDelegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton=YES;
    self.coverView.hidden=NO;
    self.coverViewHidden=YES;
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text=nil;
    self.searchBar.showsCancelButton=NO;
    [self.searchBar resignFirstResponder];
    
    self.coverViewHidden=NO;
    self.coverView.hidden=YES;
    self.tableView.hidden=YES;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText length]) {
        searchText=[searchText lowercaseString];
        self.tableView.string=searchText;
        self.tableView.hidden=NO;
    }else
    {
        self.tableView.hidden=YES;
    }
    
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.totalArray[section] cities] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.totalArray.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.totalArray[section] title];
}


#pragma mark - UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* str=@"My cell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text=[_totalArray[indexPath.section] cities][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:City_Change_Notifaction object:nil userInfo:@{city_name:[self.totalArray[indexPath.section] cities][indexPath.row]}];
}

-(void)dealloc
{
//controller 比view先dealloc
}



@end
