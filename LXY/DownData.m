//
//  DownData.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/19.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "DownData.h"

@implementation DownData


+(NSArray*)arryWithJsonData:(NSDictionary*)dict
{
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *dictArray = [dict objectForKey:@"deals"];
        for (NSDictionary *dict in dictArray) {
            DownData* md=[[DownData alloc] init];

            md.categories = dict[@"categories"];
            md.city = dict[@"city"];
            md.current_price = [dict[@"current_price"]stringValue];
            md.deal_url = dict[@"deal_url"];
            md.Description = dict[@"description"];
            md.image_url = dict[@"image_url"];
            
            md.image_url=[md.image_url stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
            md.s_image_url = dict[@"s_image_url"];
            md.list_price = [dict[@"list_price"]stringValue];
            md.purchase_count = dict[@"purchase_count"];
            md.title = dict[@"title"];
            md.deal_h5_url=dict[@"deal_h5_url"];
            [arr addObject:md];
        }
        return arr;
}
@end
