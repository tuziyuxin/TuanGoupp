//
//  UIImage+AddImage.m
//  PhotoTake
//
//  Created by Xinyu Liang on 16/10/5.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import "UIImage+AddImage.h"

@implementation UIImage (AddImage)
#pragma mark - imagescaling
- (UIImage *)imageByScalingToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}
+(UIImage*)imageWithText:(NSString*) string scale:(CGFloat) scale size:(CGSize)size
{
    //将字体进行初始化
    UIFont * font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    font=[font fontWithSize:font.pointSize*scale];
    NSMutableParagraphStyle* parastyle=[[NSMutableParagraphStyle alloc] init];
    parastyle.alignment=NSTextAlignmentCenter;
    
    NSAttributedString* text=[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:parastyle,NSStrokeColorAttributeName:[UIColor blackColor],NSForegroundColorAttributeName:[UIColor blackColor],NSStrokeWidthAttributeName:@3}];
    
    //进行对image的提取
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [text drawInRect:CGRectMake((size.width-text.size.width)/2, (size.height-text.size.height)/2, text.size.width, text.size.height)];
    UIImage * image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
