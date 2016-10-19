//
//  Cities.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/18.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cities : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* pinYin;
@property(nonatomic,copy)NSString* pinYinHead;
@property(nonatomic,copy)NSArray* regions;

-(NSArray*)loadPlist;
@end
