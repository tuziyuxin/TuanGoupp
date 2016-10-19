//
//  SearchTableView.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/18.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString* string;

@end
