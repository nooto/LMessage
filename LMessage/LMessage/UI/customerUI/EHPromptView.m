/*### WS@H Project:EHouse ###*/
//
//  EHPromptView.m
//  EHouse
//
//  Created by user on 15/4/2.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHPromptView.h"
#import "EHSysScreen.h"
@interface EHPromptView ()
@property (nonatomic, strong) UILabel *mTipLabel;
@property (nonatomic, strong) UIButton *mTipButton;
@property (nonatomic, copy) void(^finished)();
@end

@implementation EHPromptView
-(id)initWithPromptString:(NSString *)PromptText image:(NSString *)name complete:(void (^)())finish{
    self = [super initWithFrame:CGRectMake(SCREEN_W/4, SCREEN_H * (1 - 0.618), SCREEN_W, SCREEN_H/4)];
    if (self) {
        UIImage *image = [UIImage imageNamed:name];
        UIButton *imageView = [[UIButton alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - image.size.width)/2,
                                                                         floorf((CGRectGetHeight(self.frame)-image.size.height)/2),
                                                                         image.size.width,
                                                                         image.size.height)];
        [imageView setImage:image forState:UIControlStateHighlighted];
        [imageView setImage:image forState:UIControlStateNormal];
        [imageView addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        self.mTipButton = imageView;
        [self addSubview:imageView];
        
        if (PromptText.length <= 0) {
            PromptText = @"暂无数据";
        }
        
        NSDictionary *atts = @{NSFontAttributeName:Font15};
        CGRect rect = [PromptText boundingRectWithSize:CGSizeMake(SCREEN_W - MarginH(20)*2 , 100)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:atts
                                               context:nil];
        
        _mTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20),CGRectGetMaxY(imageView.frame)+MarginH(10), rect.size.width, rect.size.height)];
        _mTipLabel.text = PromptText;
        _mTipLabel.textColor = Color_9b9b9b;
        _mTipLabel.font = Font15;
        _mTipLabel.textAlignment = NSTextAlignmentCenter;
        _mTipLabel.center = CGPointMake(self.frame.size.width/2, _mTipLabel.center.y);
        _mTipLabel.numberOfLines = 2;
        [self addSubview:_mTipLabel];
        _mPrompText = _mTipLabel.text;
        
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.finished = finish;
    }

    return self;
}

-(id)initWithPromptString:(NSString*)PromptText complete:(void (^)())finish{
   return [self initWithPromptString:PromptText image:@"prompt" complete:finish];
}

-(void)setMPrompText:(NSString *)mPrompText{
    _mPrompText = mPrompText;
    [self.mTipLabel setText:mPrompText];
    
    NSDictionary *atts = @{NSFontAttributeName:_mTipLabel.font};
    CGRect rect = [mPrompText boundingRectWithSize:CGSizeMake(SCREEN_W - MarginH(20)*2 , 100)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:atts
                                           context:nil];
    
    [_mTipLabel setFrame:CGRectMake(MarginH(20),
                                    CGRectGetMaxY(self.mTipButton.frame)+MarginH(20),
                                    rect.size.width,
                                    rect.size.height)];
    _mTipLabel.center = CGPointMake(self.frame.size.width/2, _mTipLabel.center.y);
}
-(void)setMPrompImage:(UIImage *)mPrompImage{
    [self.mTipButton setImage:mPrompImage forState:UIControlStateHighlighted];
    [self.mTipButton setImage:mPrompImage forState:UIControlStateNormal];
}


-(void)tapAction:(UIButton*)sender{
    if (self.finished) {
        self.finished();
    }
}

-(void)show:(BOOL)show{
    self.center = CGPointMake(SCREEN_W/2, SCREEN_H/3);
    self.hidden = !show;
    if (!self.hidden) {
        self.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
}

@end
