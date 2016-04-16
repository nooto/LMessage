/*### WS@H Project:EHouse ###*/
//
//  ViewController.h
//  EHouse
//
//  Created by admin on 15/3/12.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EHSysProperty.h"
#import "EHSysScreen.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UILabel+AutoSize.h"
#import "UITextField+Placeholder.h"
#import "EHCustomNavBar.h"
//#import "UIScrollView+Category.h"  //中文输入法 关闭键盘后容易出现 [UIKBBlurredKeyView candidateList] 崩溃。
typedef enum{
    //
    source_Login,    //从登录/注册/页面几日努
    source_setting,  //从家庭设置进入。
    
}SourceView;

typedef enum{
    Switch_OFF,
    Switch_ON,
    Switch_NONE
}EHSwitch_Statues;

@interface EHBaseViewController : UIViewController

- (MBProgressHUD *)progressHUD;


- (void)showProgressHUDWithMessage:(NSString *)message;
- (void)hideProgressHUD:(BOOL)animated;
- (void)showProgressHUDCompleteMessage:(NSString *)message;
- (void)addHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide;
- (void)addHorizontalHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide;
- (void)removeHUD;

//非阻断式
- (void)showProgressHUDWithMessage:(NSString *)message superView:(UIView *)superView;
//非阻断式 提示消息
-(void)showAlertMessage:(NSString*)msg hideAfterDeley:(BOOL)hide atPoint:(CGPoint)center;
-(void)showAlertMessage:(NSString*)msg hideAfterDeley:(BOOL)hide;
-(void)removeAlertMessage;

-(BOOL)checkNetWork;
-(BOOL)checkTopViewController;

-(void)pushViewController:(UIViewController*)vc;
-(void)pushViewControllerNoAnimated:(UIViewController*)vc;
-(void)popViewControllerNoAnimated;
-(void)popViewControllerAnimated;
-(void)popToRootViewControllerAnimated;
-(void)popToRootViewControllerNoAnimated;

-(void)addNewDevicesFinish;
-(void)notifyLogout;
-(void)closeKeyBoard;

/**
 *  自定义导航栏实现。
 *
 */
@property (nonatomic, strong) EHCustomNavBar *mNavBarView;

- (void)backBtnPressed:(UIButton *)sender;

- (void)addRightButton:(UIButton*)button;
-(void)hiddeBackButton;
-(void)showBackButton;
-(void)setBackButtonImage:(UIImage*)image;
-(void)setBackButtonText:(NSString*)text;
//********************************

@end

