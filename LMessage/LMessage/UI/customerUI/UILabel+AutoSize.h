/*### WS@H Project:EHouse ###*/
//
//  UILabel+AutoSize.h
//  EHouse
//
//  Created by GaoAng on 15/4/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (UILabel_AutoSize)

-(void)setTextWithAdjustWidth:(NSString*)text;

/**
 *  保持label 宽度不变，自适配高度
 */
-(void)adjustLabelWidth;


-(void)adjustLabelHeight;


/**
 *  报纸控件 高度，自适配宽度。
 *
 *  @param text
 */
-(void)setTextWithAdjustHeight:(NSString*)text;
-(void)adjustLableForHeight;




/**
 
 *  修改富文本的颜色
 
 *
 
 *  @param str   要改变的string
 
 *  @param color 设置颜色
 
 *  @param range 设置颜色的文字范围
 
 *
 
 *  @return 新的AttributedString
 
 */

- (NSMutableAttributedString *)setTextColorWithStr:(NSString *)str Color:(UIColor *)color Range:(NSRange)range;



/**
 
 *  修改富文本的字体
 
 *
 
 *  @param str   要改变的string
 
 *  @param font  设置字体
 
 *  @param range 设置字体的文字范围
 
 *
 
 *  @return 新的AttributedString
 
 */

- (NSMutableAttributedString *)setTextFontWithStr:(NSString *)str Font:(UIFont *)font Range:(NSRange)range;

-(void)adjustLabelHeightForAttributedText;
@end
