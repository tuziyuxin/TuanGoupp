//
//  BarView.m
//  LXY
//
//  Created by Xinyu Liang on 16/10/16.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "BarView.h"
#import "PopViewController.h"


@interface BarView ()

@property (weak, nonatomic) IBOutlet UIButton * button;

@end

@implementation BarView

+(instancetype)createItem
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BarView" owner:self options:nil] lastObject];
}

//这种方法可以为button添加target和action
-(void)addTarget:(id)target action:(SEL)sel
{
    [self.button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];

}


#warning Xcode的原因
-(void)button:(id)obj
{
    
}
@end
