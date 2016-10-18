//
//  CategoryModel.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property(nonatomic,copy)NSString* name;

@property(nonatomic,copy)NSString* highlightedIcon;
@property(nonatomic,copy)NSString* icon;
@property(nonatomic,copy)NSString* smallHighlightedIcon;
@property(nonatomic,copy)NSString* smallIcon;

@property(nonatomic,strong)NSArray* subClass;

-(NSArray*)loadPlist;
@end
