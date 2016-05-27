//
//  AppDelegate.h
//  LMessage
//
//  Created by GaoAng on 16/3/21.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#define RootNavigation  (UINavigationController*)( ((AppDelegate *)([UIApplication sharedApplication].delegate)).window.rootViewController)

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;


@end

