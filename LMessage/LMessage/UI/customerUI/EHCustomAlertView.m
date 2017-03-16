//
//  EHCustomAlertView.m
//  EHouse
//
//  Created by GaoAng on 15/11/4.
//  Copyright © 2015年 wondershare. All rights reserved.
//

#import "EHCustomAlertView.h"
#import "UILabel+AutoSize.h"
#import "UILabel+AutoSize.h"

@interface EHCustomAlertView ()
@property (nonatomic, weak) UIView     *mContentView;
@property (nonatomic, weak) UIView     *mBgView;
@property (nonatomic, weak) UILabel    *mTitleLabel;
@property (nonatomic, weak) UILabel    *mMessageLabel;
@property (nonatomic, weak) UIView     *mLine;
@property (nonatomic, weak) UIButton   *mLeftButton;
@property (nonatomic, weak) UIView     *mLine1;
@property (nonatomic, weak) UIButton   *mRightButton;

//数据源
@property (nonatomic, strong) NSArray *mArrTitles;
@property (nonatomic, copy) NSString *mTitle;
@property (nonatomic, copy) NSString *mMessage;
@property (nonatomic, copy) void (^didSelcectButtonAtindex)(NSInteger index, NSString *buttonText);
@property (nonatomic, weak) id<EHCustomAlertViewDelegate> m_delegate;
@end

@implementation EHCustomAlertView
-(id)initWithTitle:(NSString*)title message:(NSString*)message  leftButton:(NSString*)leftTitle rightButton:(NSString*)rightTitle withDelegate:(id)delegate{
    if (self  = [self initWithTitle:title message:message leftButton:leftTitle rightButton:rightTitle]) {
        self.m_delegate = delegate;
    }
    return self;
}

-(id)initWithTitle:(NSString*)title message:(NSString*)message  leftButton:(NSString*)leftTitle rightButton:(NSString*)rightTitle selectActin:(void(^)(NSInteger index, NSString *buttonText))complete{
    if (self  = [self initWithTitle:title message:message leftButton:leftTitle rightButton:rightTitle]) {
        self.didSelcectButtonAtindex = complete;
        
    }
    return self;
}

-(id)initWithTitle:(NSString*)title message:(NSString*)message  leftButton:(NSString*)leftTitle rightButton:(NSString*)rightTitle{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)]) {
        self.mTitle = title;
        self.mMessage = message;
        self.duration = 0.35f;
        self.alpha = 0.4f;
        self.buttonTitleFont = Font15;
//        self.isClearKeyWindow = NO;
        self.contentViewCornerRadius = 10.0f;
        self.isForceSelect = YES;
        self.animationType = Alert_Animate_FadeOut;
        _messageColor = Color_5a5a5a;
        _titleColor = Color_5a5a5a;
        _leftButtonTitleColor = Color_828282;
        _rightButtonTitleColor = Color_Main;

        //构建页面。
        //大背景
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor blackColor];
        [self addSubview:view];
        self.mBgView = view;
        
        //内容背景
        view = [[UIView alloc] initWithFrame:CGRectMake(MarginH(40), CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds) - MarginH(40)*2, 40)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = _contentViewCornerRadius;
        [self addSubview:view];
        self.mContentView = view;
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), 15, CGRectGetWidth(view.frame) - MarginH(20)*2, 20)];
        [titleLabel setText:title];
        titleLabel.font = Font15;
        titleLabel.textColor = Color_5a5a5a;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.mContentView addSubview:titleLabel];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(CGRectGetWidth(_mContentView.frame)/2, titleLabel.center.y);
        self.mTitleLabel = titleLabel;
        
        //信息
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MarginH(20), CGRectGetMaxY(titleLabel.frame)+ 20, CGRectGetWidth(self.mContentView.frame)-MarginH(20)*2, 100)];
        titleLabel.center = CGPointMake(CGRectGetWidth(_mContentView.frame)/2, titleLabel.center.y);
        titleLabel.font = Font15;
        titleLabel.textColor = _messageColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:message];
        [titleLabel sizeToFitForHeight];
        [self.mContentView addSubview:titleLabel];
        self.mMessageLabel = titleLabel;
        [self checkeMessageHieht];
        
        //按钮。。
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+ MarginH(20), CGRectGetWidth(self.mContentView.frame), 0.5f)];
        lineView.backgroundColor = Color_Line;
        [self.mContentView addSubview:lineView];
        self.mLine = lineView;
        
        //按钮显示...
        CGFloat buttonWidht = CGRectGetWidth(self.mContentView.frame);
        //两个按钮。
        if (leftTitle.length >0 && rightTitle.length > 0) {
            buttonWidht = CGRectGetWidth(self.mContentView.frame)/2;
            UIButton *buttont = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), buttonWidht, 45)];
            buttont.backgroundColor = [UIColor clearColor];
            buttont.tag = 0;
            [buttont setTitle:leftTitle forState:UIControlStateNormal];
            [buttont setTitleColor:_leftButtonTitleColor forState:UIControlStateNormal];
            [buttont.titleLabel setFont:self.buttonTitleFont];
            [self.mContentView addSubview:buttont];
            [buttont addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.mLeftButton = buttont;
            
            buttont = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(buttont.frame), CGRectGetMaxY(lineView.frame), buttonWidht, 45)];
            buttont.backgroundColor = [UIColor clearColor];
            [buttont setTitle:rightTitle forState:UIControlStateNormal];
            buttont.tag = 1;
            [buttont setTitleColor:_rightButtonTitleColor forState:UIControlStateNormal];
            [buttont.titleLabel setFont:self.buttonTitleFont];
            [self.mContentView addSubview:buttont];
            [buttont addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.mRightButton = buttont;

            //中间分割线
            UIView*linew = [[UIView alloc] initWithFrame:CGRectMake(buttonWidht, CGRectGetMinY(buttont.frame), 0.5f, CGRectGetHeight(buttont.frame))];
            linew.backgroundColor = Color_Line;
            [self.mContentView addSubview:linew];
            self.mLine1 = linew;
            
            CGRect frame = self.mContentView.frame;
            frame.size.height = CGRectGetMaxY(buttont.frame);
            self.mContentView.frame = frame;
        }
        else{
            //
            NSString* titleText = @"确定";
            if (leftTitle.length > 0) {
                titleText = leftTitle;
            }
            if (rightTitle.length > 0) {
                titleText = rightTitle;
            }
            UIButton *buttont = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame), buttonWidht, 45)];
            buttont.backgroundColor = [UIColor clearColor];
            [buttont setTitle:titleText forState:UIControlStateNormal];
            [buttont setTitleColor:_leftButtonTitleColor forState:UIControlStateNormal];
            buttont.tag = 0;
            [buttont.titleLabel setFont:self.buttonTitleFont];
            [buttont addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.mContentView addSubview:buttont];
            self.mLeftButton = buttont;

            CGRect frame = self.mContentView.frame;
            frame.size.height = CGRectGetMaxY(buttont.frame);
            self.mContentView.frame = frame;
        }
        
    }
    
    return self;
}
-(void)setAttributedMessage:(NSAttributedString *)sttributedMessage{
    UIFont *font = self.mMessageLabel.font;
    [self.mMessageLabel setText:[sttributedMessage string]];
    [self.mMessageLabel setFont:[UIFont systemFontOfSize:20]];
    [self.mMessageLabel sizeToFitForHeight];
//    self.mMessageLabel.backgroundColor = [UIColor grayColor];
    [self setMessageFont:[UIFont systemFontOfSize:20]];
    [self.mMessageLabel setFont:font];
    [self.mMessageLabel setAttributedText:sttributedMessage];
}


#pragma mark - p
-(void)setBackgroundViewColor:(UIColor *)backgroundViewColor{
    _backgroundViewColor = backgroundViewColor;
    _mBgView.backgroundColor = backgroundViewColor;
}
-(void)setContentViewCornerRadius:(CGFloat)contentViewCornerRadius{
    _contentViewCornerRadius = contentViewCornerRadius;
    _mContentView.layer.cornerRadius = contentViewCornerRadius;
}
-(void)setContentViewbackgroundColor:(UIColor *)contentViewbackgroundColor{
    _contentViewbackgroundColor = contentViewbackgroundColor;
    [_mContentView setBackgroundColor:_contentViewbackgroundColor];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.mTitleLabel setTextColor:titleColor];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self.mTitleLabel setFont:titleFont];
}

-(void)setMessageColor:(UIColor *)messageColor{
    _messageColor = messageColor;
    [self.mMessageLabel setTextColor:messageColor];
}

-(void)setLeftButtonTitleColor:(UIColor *)leftButtonTitleColor{
    _leftButtonTitleColor = leftButtonTitleColor;
    if (self.mLeftButton) {
        [self.mLeftButton setTitleColor:leftButtonTitleColor forState:UIControlStateNormal];
    }
}

-(void)setRightButtonTitleColor:(UIColor *)rightButtonTitleColor{
    _rightButtonTitleColor = rightButtonTitleColor;
    if (self.mRightButton) {
        [self.mRightButton setTitleColor:_rightButtonTitleColor forState:UIControlStateNormal];
    }
}

-(void)checkeMessageHieht{
    if (CGRectGetHeight(self.mMessageLabel.frame) > SCREEN_H /3) {
        CGRect frame = self.mMessageLabel.frame;
        frame.size.height = SCREEN_H/3;
        self.mMessageLabel.frame = frame;
    }
}

-(void)setMessageFont:(UIFont *)messageFont{
    _messageFont = messageFont;
    [self.mMessageLabel setFont:messageFont];
    [self.mMessageLabel sizeToFitForHeight];
    [self checkeMessageHieht];
    
    //按钮。。
    [self.mLine setFrame:CGRectMake(0, CGRectGetMaxY(self.mMessageLabel.frame)+ MarginH(20), CGRectGetWidth(self.mContentView.frame), 0.5f)];
    
    if (self.mLeftButton) {
        CGRect frame = self.mLeftButton.frame;
        frame.origin.y = CGRectGetMaxY(self.mLine.frame);
        self.mLeftButton.frame = frame;
        
        
        frame = self.mContentView.frame;
        frame.size.height = CGRectGetMaxY(self.mLeftButton.frame);
        self.mContentView.frame = frame;

    }
    
    if (self.mRightButton) {
        CGRect frame = self.mRightButton.frame;
        frame.origin.y = CGRectGetMaxY(self.mLine.frame);
        self.mRightButton.frame = frame;
        
        frame = self.mContentView.frame;
        frame.size.height = CGRectGetMaxY(self.mRightButton.frame);
        self.mContentView.frame = frame;
    }
    
    if (self.mLine1) {
        CGRect frame = self.mLine1.frame;
        frame.origin.y = CGRectGetMaxY(self.mLine.frame);
        self.mLine1.frame = frame;
    }
    
}

-(void)setMessageTextAlignment:(NSTextAlignment)messageTextAlignment{
    
    _messageTextAlignment = messageTextAlignment;
    [self.mMessageLabel setTextAlignment:messageTextAlignment];
}

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor{
    [self.mLeftButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [self.mRightButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

-(void)setButtonTitleFont:(UIFont *)buttonTitleFont{
    self.mLeftButton.titleLabel.font = self.mRightButton.titleLabel.font = buttonTitleFont;
}

#pragma mark -
-(void)buttonAction:(UIButton*)sender{
    [self disMisss];
    
    //支持委托方式
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(customAlertView:clickedButtonAtIndex:)]) {
        [_m_delegate customAlertView:self clickedButtonAtIndex:sender.tag];
    }
    
    //支持block 方式初始化。
    if (_didSelcectButtonAtindex) {
        _didSelcectButtonAtindex(sender.tag, sender.titleLabel.text);
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (!_isForceSelect) {
        [self disMisss];
    }
}

-(void)show{
//    if (self.isClearKeyWindow) {
//        for (UIView *subnView in [UIApplication sharedApplication].keyWindow.subviews) {
//            NSLog(@"%@",[subnView description]);
//        }
////        [UIApplication sharedApplication].keyWindow  
//    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.mBgView.alpha = 0.0f;
    switch (self.animationType) {
        case Alert_Animate_Down:{
            _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)+CGRectGetHeight(_mContentView.frame)/2);
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = _alpha;
                _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) * 0.5);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case Alert_Animate_Up:{
            _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, -CGRectGetHeight(_mContentView.frame)/2);
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = _alpha;
                _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) * 0.5);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case Alert_Animate_FadeOut:{
            _mContentView.alpha = 0.0f;
            _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) * 0.5);
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = _alpha;
                _mContentView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case Alert_Animate_None:{
            _mBgView.alpha = _alpha;
            _mContentView.alpha =1.0f;
            _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) * 0.5);
    }
            break;
            
        default:
            break;
    }
}

-(void)disMisss{
    
    switch (self.animationType) {
        case Alert_Animate_Down:{
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = 0.0f;
                _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)+CGRectGetHeight(_mContentView.frame)/2);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];;
//                [self removeFromSuperview];
            }];

        }
            break;
            
        case Alert_Animate_Up:{
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = 0.0f;
                _mContentView.center = CGPointMake(CGRectGetWidth(self.frame)/2, -CGRectGetHeight(_mContentView.frame)/2);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];;
            }];

        }
            break;
            
        case Alert_Animate_FadeOut:{
            _mContentView.alpha = 1.0f;
            [UIView animateWithDuration:_duration animations:^{
                _mBgView.alpha = 0.0f;
                _mContentView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];;
            }];

        }
            break;
            
        case Alert_Animate_None:{
            [self removeFromSuperview];;
        }
            break;
            
        default:
            break;
    }
}
@end
