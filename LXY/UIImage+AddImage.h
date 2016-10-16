//
//  UIImage+AddImage.h
//  PhotoTake
//
//  Created by Xinyu Liang on 16/10/5.
//  Copyright © 2016年 Xinyu Liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AddImage)
- (UIImage *)imageByScalingToSize:(CGSize)size;
+(UIImage*)imageWithText:(NSString*) string scale:(CGFloat) scale size:(CGSize)size;

@end
