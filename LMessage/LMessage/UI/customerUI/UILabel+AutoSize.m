/*### WS@H Project:EHouse ###*/
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
    if (self.text.length > 0  && self.font) {
        CGSize testSize = TEXTSIZE(self.text,self.font);//[self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
        CGRect frame = self.frame;
        frame.size.width = testSize.width;
//        frame.size.height = testSize.height;
        self.frame =frame;
    }
    else{
        CGRect frame = self.frame;
        frame.size.width = 0;
//        frame.size.height = 0;
        self.frame = frame;
    }
}

-(void)adjustLabelHeight{
    if (self.text && self.font) {
        CGSize testSize = MB_MULTILINE_TEXTSIZE(self.text, self.font, CGSizeMake(self.frame.size.width, MAXFLOAT), 0);//[self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
        CGRect frame = self.frame;
        frame.size.height = testSize.height;
        self.numberOfLines = 0;
        self.frame =frame;
    }
}

-(void)setTextWithAdjustHeight:(NSString*)text{
    [self setText:text];
    [self adjustLableForHeight];
}

-(void)adjustLableForHeight{
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName,nil];
    CGSize testSize = TEXTSIZE(self.text,self.font);//[self.text sizeWithAttributes:dic];
    NSInteger line =  testSize.width / CGRectGetWidth(self.frame) + 1;
    self.numberOfLines = line;
    CGRect frame = self.frame;
    frame.size.height = line * testSize.height;
    
    self.frame =frame;
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
