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


-(void)sizeToFitWithText:(NSString*)text MaxWidth:(CGFloat)maxWidth;
- (void)sizeToFitWithMaxWidth:(CGFloat)maxWidth;

-(void)setTextWithAdjustWidth:(NSString*)text;

/**
 *  保持label 宽度不变，自适配高度
 */
-(void)adjustLabelWidth;


/**
 *  报纸控件 高度，自适配宽度。
 *
 *  @param text
 */
-(void)setTextWithAdjustHeight:(NSString*)text;
-(void)adjustLableForHeight;

@end
