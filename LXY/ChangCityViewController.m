//
//  ChangCityViewController.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/17.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "ChangCityViewController.h"
#import "ChangCityView.h"
#import "CityGroup.h"

@interface ChangCityViewController ()

@end

@implementation ChangCityViewController
{
    ChangCityView* _cityView;
}

-(void)loadView
{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cityView=[ChangCityView createView];
    _cityView.totalArray=[[CityGroup alloc] loadCityGroup];
    _cityView.autoresizingMask=UIViewAutoresizingNone;
    [_cityView addObserver:self forKeyPath:@"coverViewHidden" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_cityView];
    
    self.preferredContentSize=CGSizeMake(_cityView.frame.size.width, _cityView.frame.size.height);
    

}


//监视来控制coverview是否被覆盖， 即view中有东西反馈到controller

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
#warning 虽然值为0，但是其由于是对象，所以并不会判断为否定.
#warning valueForKeyPath: 会包装成对象，而change里面的也是对象：NSNumber
    if ([object coverViewHidden]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
 }


#warning  要记得在此处加上清除observer，如果不，会报仍然有人在监听_cityView的错
-(void)dealloc{
    [_cityView removeObserver:self forKeyPath:@"coverViewHidden"];
}

@end
