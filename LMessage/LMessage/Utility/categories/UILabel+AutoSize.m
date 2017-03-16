 //
//  UILabel+AutoSize.m
//  EHouse
//
//  Created by GaoAng on 15/4/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "UILabel+AutoSize.h"
#import <UIKit/UIKit.h>
@interface UILabel ()

@end

@implementation UILabel (UILabel_AutoSize)


- (void)sizeToFitForWidth{
    [self sizeToFitWithMaxWidth:CGRectGetWidth(self.frame)];
}

-(void)sizeToFitWithMaxWidth:(CGFloat)maxWidth{
    CGRect frame = self.frame;
    self.numberOfLines = 0;//多行显示，计算高度
    CGSize titleSize = [self.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;

    frame.size.height = titleSize.height;
    [self setFrame:frame];
}


- (void)sizeToFitForHeight{
    [self sizeToFitWithMaxHeight:CGRectGetHeight(self.frame)];
}

- (void)sizeToFitWithMaxHeight:(CGFloat)maxHeight{
    CGRect frame = self.frame;
    self.numberOfLines = 0;//多行显示，计算高度
    CGSize titleSize = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    frame.size.height = titleSize.height;
    [self setFrame:frame];
}


- (NSMutableAttributedString *)setTextColorWithStr:(NSString *)str Color:(UIColor *)color Range:(NSRange)range{

    if (str == nil) return nil;

    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:str];

    [newStr addAttribute:NSForegroundColorAttributeName value:color range:range];

    return newStr;

}

- (NSMutableAttributedString *)setTextFontWithStr:(NSString *)str Font:(UIFont *)font Range:(NSRange)range{

    if (str == nil) return nil;

    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:str];

    [newStr addAttribute:NSFontAttributeName value:font range:range];

    return newStr;

}

-(void)adjustLabelHeightForAttributedText{
    if (self.attributedText) {
            //消息内容frame
        CGSize maxSize = CGSizeMake(self.frame.size.width/2, MAXFLOAT);
            //设定attributedString的字体及大小，一定要设置这个，否则计算出来的height是非常不准确的
        CGRect contentRect = [self.attributedText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        [self setFrame:contentRect];
    }
    
    
}

@end
