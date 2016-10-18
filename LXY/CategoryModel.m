//
//  CategoryModel.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

-(NSArray*)loadPlist
{
    NSString* plistString=[[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    NSArray* categoriesTotal=[NSArray arrayWithContentsOfFile:plistString];
    NSArray* array=nil;
    array=[self loadDataIntoArray:categoriesTotal];//把其变为类方法后，不可以调用self 的一些东西，会变成类
    return array;
}

-(NSArray* )loadDataIntoArray:(NSArray*)array
{
    NSMutableArray* mutableArray=[[NSMutableArray alloc] init];
    for(NSDictionary* dict in array)
    {
        CategoryModel* md=[self getMDFromDict:dict];
        [mutableArray addObject:md];
        
    }
    return mutableArray;
}

-(CategoryModel*)getMDFromDict:(NSDictionary*)dict
{
    CategoryModel* md=[[CategoryModel alloc] init];
    md.name=[dict objectForKey:@"name"];
    md.highlightedIcon=[dict objectForKey:@"highlighted_icon"];
    md.icon=[dict objectForKey:@"icon"];
    md.smallHighlightedIcon=[dict objectForKey:@"small_highlighted_icon"];
    md.smallIcon=[dict objectForKey:@"small_icon"];
    md.subClass=[dict objectForKey:@"subcategories"];
    return md;
}

@end
