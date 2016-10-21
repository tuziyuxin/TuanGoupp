//
//  DownData.h
//  LXY
//
//  Created by Xinyu Liang on 16/10/19.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownData : NSObject
// 商品分类
@property (nonatomic,copy)NSString *categories;
//所在城市
@property (nonatomic,copy)NSString *city;
//价格
@property (nonatomic,copy)NSString *current_price;
//h5
@property (nonatomic,copy)NSString *deal_h5_url;
//deal_url
@property (nonatomic,copy)NSString *deal_url;
//description
@property (nonatomic,copy)NSString *Description;
//image_url
@property (nonatomic,copy)NSString *image_url;
//s_image_url
@property (nonatomic,copy)NSString *s_image_url;
//list_price
@property (nonatomic,copy)NSString *list_price;
//purchase_deadline
@property (nonatomic,copy)NSString *purchase_count;
//title
@property (nonatomic,copy)NSString *title;


+(NSArray*)arryWithJsonData:(id)data;
@end
