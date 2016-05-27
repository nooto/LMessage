/*### WS@H Project:EHouse ###*/
//
//  EHCustomNavBar.m
//  EHouse
//
//  Created by GaoAng on 15/9/16.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHCustomNavBar.h"
#import "UILabel+AutoSize.h"

@interface EHCustomNavBar ()
//@property (nonatomic, assign) id<EHSceneTitleViewDelegate> m_delegate;

@end
@implementation EHCustomNavBar

-(id)initWithdelegate:(id)delegate{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, NAVBAR_H)]) {
        self.m_delegate = delegate;
        [self setUpView];
    }
    return self;
}

-(void)setUpView{

    self.backgroundColor = Color_BackGround;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.7f;
    self.layer.shadowColor   = Color_Line.CGColor;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.image = [UIImage imageNamed:@"global_img_navbg"];
    [self addSubview:bgImageView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 20)];
    [self addSubview:titleLabel];
    titleLabel.center = CGPointMake(SCREEN_W/2, CGRectGetHeight(self.bounds)/2 + 10);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font_Navigation;
    titleLabel.textColor = Color_Text_Main;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    self.mTextLabel = titleLabel;
    
    EHNavButton* leftButton =  [[EHNavButton alloc] initWithFrame:CGRectMake(0, 0, NAVBAR_H*2, NAVBAR_H)];
    [leftButton setImage:[UIImage imageNamed:@"global_arrow_previous"] forState:UIControlStateNormal];
//    [leftButton setImage:[UIImage imageNamed:@"btn_login_back_pressed"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButonAction:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = _mTextLabel.font;
    [leftButton setTitleColor:Color_Text_Adjunct forState:UIControlStateNormal];
    [leftButton setTitleColor:Color_Text_Display forState:UIControlStateHighlighted];
    [self addSubview:leftButton];
    self.mLeftButton = leftButton;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.mTextLabel setText:title];
    self.mTextLabel.center = CGPointMake(SCREEN_W/2, CGRectGetHeight(self.bounds)/2 + 10);
}
-(void)leftButonAction:(UIButton*)sender{
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(backBtnPressed:)]) {
        [_m_delegate backBtnPressed:sender];
    }
}

@end
