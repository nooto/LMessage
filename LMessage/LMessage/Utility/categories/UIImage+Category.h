//
//  UIImage+Category.h
//  Utility
//
//  Created by GaoAng on 15/10/13.
//  Copyright © 2015年 GaoAng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImage (Category)

- (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageWithFillColor:(UIColor *)color;

+ (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size;
+ (UIImage *)createRoundedRectImage:(UIImage *)image Withsize:(CGSize)size radius:(NSInteger)radius
;
//+ (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size;//默认设置为圆形
+ (UIImage *)scaleImageFromImageView:(UIImageView *)imageView;//添加默认尺寸
+ (UIImage *)scaleImageFromImageView:(UIImageView *)imageView imageBounds:(CGRect)imageBounds;//添加指定尺寸

@end

