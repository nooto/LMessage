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
@interface EHBaseViewController : UIViewController

//联网状态显示与影藏
- (void)addHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide;
- (void)removeHUD;

//导航栏操作封装。
-(void)pushViewController:(UIViewController*)vc;
-(void)pushViewControllerNoAnimated:(UIViewController*)vc;
-(void)popViewControllerNoAnimated;
-(void)popViewControllerAnimated;
-(void)popToRootViewControllerAnimated;
-(void)popToRootViewControllerNoAnimated;


/**
 *  关闭屏幕键盘。
 */
- (void)closeKeyBoard;
@end

