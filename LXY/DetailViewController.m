//
//  DetailViewController.m
//  团购项目
//
//  Created by lb on 15/9/16.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "DetailViewController.h"
#import "DownData.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()
//导航栏返回点击事件
- (IBAction)backClick;
@property (weak, nonatomic) IBOutlet UIWebView *webVIew;//右侧webview
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//商品图片

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* deal_h5_url=[_md.deal_h5_url stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:deal_h5_url]];
    [_webVIew loadRequest:request];
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_md.image_url]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}


- (IBAction)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
