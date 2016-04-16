//
//  UIImage+Category.m
//  Utility
//
//  Created by GaoAng on 15/10/13.
//  Copyright © 2015年 GaoAng. All rights reserved.
//

#import "UIImage+Category.h"
@implementation UIImage (Category)
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    [color setFill];
    UIRectFill(rect);
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)imageWithFillColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    [color setFill];
    UIRectFill(rect);
    //    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);// Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage *)createRoundedRectImage:(UIImage *)image Withsize:(CGSize)size radius:(NSInteger)radius
{
    // the size of CGContextRef
    int width = size.width;
    UIImage * img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, width, 8, 44 * width, colorSpace, 2);  //2 = kCGImageAlphaPremultipliedFirst
    CGRect rect = CGRectMake(0, 0, width, width);
    if (context) {
        CGContextBeginPath(context);
        addRoundedRectToPath(context, rect, radius, radius);
        CGContextClosePath(context);
        CGContextClip(context);
        CGContextDrawImage(context, CGRectMake(0, 0, width, width), img.CGImage);
        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        img = [UIImage imageWithCGImage:imageMasked];
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        CGImageRelease(imageMasked);
    }
    return img;
}
+ (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size {
    if ([UIScreen mainScreen].scale == 2.0) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 0.5, size.height * 0.5) , NO, 2.0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    //设置图像上下午为圆形
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width * 0.5, size.height * 0.5));
    CGContextClip(context);
    //    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawInRect:CGRectMake(0, 0, size.width * 0.5, size.height * 0.5) blendMode:kCGBlendModeScreen alpha:1.0];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

+ (UIImage *)scaleImageFromImageView:(UIImageView *)imageView {
    return [self scaleImageFromImageView:imageView imageBounds:imageView.bounds];
}

+ (UIImage *)scaleImageFromImageView:(UIImageView *)imageView imageBounds:(CGRect)imageBounds {
    UIGraphicsBeginImageContext(imageView.bounds.size);
    CGContextRef imageViewContext = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:imageViewContext];
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = CGImageCreateWithImageInRect(tempImage.CGImage, imageBounds);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return returnImage;
}
@end
