//
//  ChangCityView.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangCityView : UIView<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)NSArray* totalArray;
@property(nonatomic)BOOL coverViewHidden;

+(instancetype)createView;

@end
