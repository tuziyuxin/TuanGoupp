//
//  BarView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "BarView.h"
#import "PopViewController.h"
#import "Constant.h"


@interface BarView ()
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UIButton * button;

@end

@implementation BarView
{
    NSString* _cityName;
}
static int a;

+(instancetype)createItem
{
   /* [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCityName:) name:City_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRegionName:) name:Region_Change_Notifaction object:nil];
   */
    return [[[NSBundle mainBundle] loadNibNamed:@"BarView" owner:self options:nil] lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    return self;
}

-(void)awakeFromNib
{
    if (a) {
        self.firstLabel.text=@"北京";
        self.secondLabel.text=@"全部";
    }else
    {
        self.firstLabel.text=@"全部分类";
        self.secondLabel.text=nil;
    }
    _cityName=@"北京";
    a++;

}

//这种方法可以为button添加target和action
-(void)addTarget:(id)target action:(SEL)sel
{
    [self.button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];

}

-(void)changeCityName:(NSNotification *)noti
{
    _cityName=noti.userInfo[city_name];
}
-(void)changeRegionName:(NSNotification*)noti

{
    self.firstLabel.text=_cityName;
    self.secondLabel.text=noti.userInfo[region_name];
    
}

-(void)changeCategoryName:(NSNotification *)noti
{
    self.secondLabel.text=noti.userInfo[category_name];
    self.firstLabel.text=noti.userInfo[subCategory_name];
    
}
-(void)changeSubCategoryName:(NSNotification*)noti
{
    self.firstLabel.text=noti.userInfo[category_name];
   
    self.secondLabel.text=noti.userInfo[subCategory_name];
}
#warning Xcode的原因
-(void)button:(id)obj
{
    
}

/*
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:City_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Region_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Category_Change_Notifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SubCategory_Change_Notifaction object:nil];
}
 */
@end
