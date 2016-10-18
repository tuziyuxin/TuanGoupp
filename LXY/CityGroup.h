//
//  CityGroup.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroup : NSObject

@property(nonatomic,copy)NSString* title;
@property(nonatomic,strong)NSArray* cities;

-(NSArray*)loadCityGroup;
@end
