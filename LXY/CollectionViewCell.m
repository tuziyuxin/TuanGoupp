//
//  CollectionViewCell.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/19.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *Description;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UILabel *listedPrice;

@property (weak, nonatomic) IBOutlet UILabel *salesNum;


@end
@implementation CollectionViewCell

#warning 新方法
-(void)awakeFromNib
{
    //给cell
    self.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
}

-(void)showUI:(DownData *)data
{
    self.title.text=data.title;
    self.Description.text=data.Description;
    self.currentPrice.text=[NSString stringWithFormat:@"¥%@",data.current_price];
    self.listedPrice.text=[NSString stringWithFormat:@"¥%@",data.list_price];
    self.salesNum.text=[NSString stringWithFormat:@"已售%@",data.purchase_count];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:data.image_url]];
    
}


 
@end
