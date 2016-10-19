//
//  Cities.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/18.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "Cities.h"

@implementation Cities

-(NSArray*)loadPlist
{
    NSString* path=[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray*  array=[NSArray arrayWithContentsOfFile:path];
    NSMutableArray* mutableArray=[[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        Cities* city=[self loadCityFromDictionary:dict];
        [mutableArray addObject:city];
    }
    return mutableArray;
}

-(Cities*)loadCityFromDictionary:(NSDictionary*)dict
{
    Cities * city=[[Cities alloc] init];
    city.name=[dict objectForKey:@"name"];
    city.pinYin=[dict objectForKey:@"pinYin"];
    city.pinYinHead=[dict objectForKey:@"pinYinHead"];
    city.regions=[dict objectForKey:@"regions"];
    return city;
}
@end
