//
//  CityGroup.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "CityGroup.h"

@implementation CityGroup


-(NSArray*)loadCityGroup
{
    NSString* str=[[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
    NSArray* array=[NSArray arrayWithContentsOfFile:str];
    
    NSArray* arrayToLoad=nil;
    arrayToLoad=[self loadPlistFromArray:array];
    return arrayToLoad;
}

-(NSArray*)loadPlistFromArray:(NSArray*)array
{
    NSMutableArray* mutableArray=[[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in array ) {
        CityGroup* city=[self loadCityFromDictionary:dict];
        [mutableArray addObject:city];
    }
    return mutableArray;
    
}
                         
-(CityGroup*)loadCityFromDictionary:(NSDictionary*)dict
{
    CityGroup* city=[[CityGroup alloc] init];
    city.cities=[dict objectForKey:@"cities"];
    city.title=[dict objectForKey:@"title"];
    return city;
}

@end
