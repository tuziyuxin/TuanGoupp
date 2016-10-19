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
@interface PopViewController() <MyPopViewDataSource>

@end

@implementation PopViewController
{
    NSArray <CategoryModel*> * _totalArray;
    NSArray* _selectedArray;
    NSInteger _selectedIndex;
}

-(void)loadView
{
    [super loadView];
}

-(void)viewDidLoad
{
   [super viewDidLoad];
    
    
    PopView* view=[PopView creatPopView];
    view.dataSource=self;
    
#warning I do not know why this has a relationship with tableview IN view
    view.autoresizingMask=UIViewAutoresizingNone;
    
    [self.view addSubview:view];
    self.preferredContentSize=CGSizeMake(view.frame.size.width, view.frame.size.height);
    
    CategoryModel* model=[[CategoryModel alloc] init];
    _totalArray=[model loadPlist];//进行赋值
}

#pragma  mark - DataSource Delegate

-(NSInteger)numberOfRowsInLeftTableViewOfView:(PopView *)view
{
    return [_totalArray count];
}


-(NSArray *)subDataOfRightViewAtIndex:(NSInteger)index View:(PopView *)view
{
    NSArray* subArray=nil;
    if (_totalArray) {
        subArray=[_totalArray[index] subClass];
    }
    return subArray;
}

-(NSString*)titleForRowAtLeft:(NSInteger)index View:(PopView *)view
{
    NSString* leftTitle=nil;
    if (_totalArray) {
        leftTitle=[_totalArray[index] name];
    }
    return leftTitle;
}

-(NSString*)titleForRowAtRight:(NSInteger)index WithLeft:(NSInteger)selectedIndex View:(PopView *)view
{
    if ((selectedIndex!=_selectedIndex)||(!_selectedArray)) {
        _selectedArray=[_totalArray[selectedIndex] subClass];
    }
    return _selectedArray[index];
}

-(NSString*)pathForImageAtLeft:(NSInteger)index View:(PopView *)view
{
    NSString* imagePath=nil;
    if (_totalArray) {
        imagePath=[_totalArray[index] icon];
    }
    return imagePath;
}











@end