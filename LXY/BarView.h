//
//  BarView.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarView : UIView

+(instancetype)createItem;

-(void)addTarget:(id)target action:(SEL)sel;

-(void)changeCityName:(NSNotification*)noti;
-(void)changeRegionName:(NSNotification*)noti;
-(void)changeCategoryName:(NSNotification*)noti;
-(void)changeSubCategoryName:(NSNotification*)noti;

@end
