//
//  UILabel+AutoSize.h
//  EHouse
//
//  Created by GaoAng on 15/4/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UILabel (UILabel_AutoSize)


/**
  更具label 的宽度进行frame的适配 制定的最大width 或者默认的width
 */
- (void)sizeToFitForWidth;
- (void)sizeToFitWithMaxWidth:(CGFloat)maxWidth;




- (void)sizeToFitForHeight;
- (void)sizeToFitWithMaxHeight:(CGFloat)maxHeight;



///**
// *  报纸控件 高度，自适配宽度。
// *
// *  @param text
// */
//-(void)setTextWithAdjustHeight:(NSString*)text;
//-(void)adjustLableForHeight;

- (NSMutableAttributedString *)setTextColorWithStr:(NSString *)str Color:(UIColor *)color Range:(NSRange)range;
- (NSMutableAttributedString *)setTextFontWithStr:(NSString *)str Font:(UIFont *)font Range:(NSRange)range;
- (void)adjustLabelHeightForAttributedText;

@end
