//
//  EHCustomAlertView.h
//  EHouse
//
//  Created by GaoAng on 15/11/4.
//  Copyright © 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    Alert_Animate_FadeOut,
    Alert_Animate_Up,
    Alert_Animate_Down,
    Alert_Animate_None,
    
}EAlertAnimationType;

@class EHCustomAlertView;
@protocol EHCustomAlertViewDelegate <NSObject>

-(void)customAlertView:(EHCustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface EHCustomAlertView : UIView

/**
 *  动画时间段...
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  背景透明度
 */
@property (nonatomic, assign) CGFloat  alpha;
/**
 *  背景色
 */
@property (nonatomic, assign) UIColor *backgroundViewColor;

/**
 *  是否 弹出控件时 是否 删除 keywindows 上的其他控件。
 */
//@property (nonatomic, assign) BOOL isClearKeyWindow;

/**
 *  是否必须选择 选项后才能消失。
 */
@property (nonatomic, assign) BOOL isForceSelect;
/**
 *  内容View 属性设置
 */
@property (nonatomic, assign) CGFloat contentViewCornerRadius;
@property (nonatomic, strong) UIColor *contentViewbackgroundColor;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont *messageFont;

@property (nonatomic, assign) NSTextAlignment messageTextAlignment;

/**
 *  左侧按钮 属性
 */
@property (nonatomic, strong) UIColor *leftButtonTitleColor;

/**
 *  右侧按钮 属性
 */
@property (nonatomic, strong) UIColor *rightButtonTitleColor;


@property (nonatomic, strong) UIFont *buttonTitleFont;


/**
 *  动画效果
 */
@property (nonatomic, assign) EAlertAnimationType animationType;



/**
 设置展示信息添加属性显示。

 @param sttributedMessage 属性字符串更新。
 */
-(void)setAttributedMessage:(NSAttributedString *)sttributedMessage;

/**
 *  支持block 通知。
 */
-(id)initWithTitle:(NSString*)title message:(NSString*)message  leftButton:(NSString*)leftTitle rightButton:(NSString*)rightTitle selectActin:(void(^)(NSInteger index, NSString *buttonText))complete;

/**
 *  支持 delegate 回调通知。
 */
-(id)initWithTitle:(NSString*)title message:(NSString*)message  leftButton:(NSString*)leftTitle rightButton:(NSString*)rightTitle withDelegate:(id)delegate;

/**
 *  提示框弹出效果
 */
-(void)show;
@end
