 //
//  UILabel+AutoSize.m
//  EHouse
//
//  Created by GaoAng on 15/4/13.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "UILabel+AutoSize.h"

@interface UILabel ()

@end

@implementation UILabel (UILabel_AutoSize)


-(void)setTextWithAdjustWidth:(NSString*)text{
    [self setText:text];
    [self adjustLabelWidth];
}

-(void)adjustLabelWidth{
    if (self.text && self.font) {
        CGSize testSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
        CGRect frame = self.frame;
        frame.size.width = testSize.width;
        self.frame =frame;
    }
}


-(void)setTextWithAdjustHeight:(NSString*)text{
    [self setText:text];
    [self adjustLableForHeight];
}

-(void)adjustLableForHeight{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName,nil];
    CGSize testSize = [self.text sizeWithAttributes:dic];
    NSInteger line =  testSize.width / CGRectGetWidth(self.frame) + 1;
    self.numberOfLines = line;
    CGRect frame = self.frame;
//    frame.size.height = line * testSize.height;
    self.frame =frame;
}

-(void)sizeToFitWithText:(NSString*)text MaxWidth:(CGFloat)maxWidth{
    [self setText:text];
    [self sizeToFitWithMaxWidth:maxWidth];
}

-(void)sizeToFitWithMaxWidth:(CGFloat)maxWidth{
    [self sizeToFit];
    if (CGRectGetWidth(self.frame) > maxWidth) {
        CGRect frame = self.frame;
        frame.size.width = maxWidth;
        [self setFrame:frame];
    }
}

@end
