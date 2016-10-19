//
//  PopView.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopView;

@protocol MyPopViewDataSource <NSObject>

-(NSInteger)numberOfRowsInLeftTableViewOfView:(PopView*)view;//得到行数

-(NSString*)titleForRowAtLeft:(NSInteger) index View:(PopView*)view;//得到左边title的名称

-(NSString*)titleForRowAtRight:(NSInteger)index WithLeft:(NSInteger)selectedIndex View:(PopView*)view;

-(NSString*)pathForImageAtLeft:(NSInteger)index View:(PopView*)view;//得到左边的image

-(NSArray*)subDataOfRightViewAtIndex:(NSInteger)index View:(PopView*)view;//得到子数据


@end



@interface PopView : UIView

@property(nonatomic,strong)id <MyPopViewDataSource> dataSource;

+(instancetype)creatPopView;




@end