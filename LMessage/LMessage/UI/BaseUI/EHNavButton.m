/*### WS@H Project:EHouse ###*/
//
//  EHNavButton.m
//  EHouse
//
//  Created by GaoAng on 15/9/16.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHNavButton.h"
#import "UtilityHelper.h"

@implementation EHNavButton

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageSize = CGSizeMake(9, 16);
        self.gapX = MarginW(20);
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect rect = contentRect;
    CGFloat posX = self.gapX + self.imageSize.width+5;
    if (!self.imageView) {
        posX = self.gapX;
    }
    rect = CGRectMake(posX, 20, CGRectGetWidth(contentRect) - posX, CGRectGetHeight(contentRect) - 20);
    return rect;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect rect = contentRect;
    rect = CGRectMake(_gapX, 10 + CGRectGetHeight(contentRect)/2 - _imageSize.height/2, _imageSize.width, _imageSize.height);
    return rect;
}


@end
