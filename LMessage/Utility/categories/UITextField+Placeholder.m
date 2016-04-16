//
//  UITextField+Placeholder.m
//  EHouse
//
//  Created by GaoAng on 15/5/21.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField(Placeholder)

- (void)setPlaceholder:(NSString *)placeholder WithColor:(UIColor*)placeholderColor{
    if (placeholder && placeholderColor) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    }
}

@end
