//
//  NavigationControllerDelegate.h
//  LMessage
//
//  Created by GaoAng on 16/4/18.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationControllerDelegate : NSObject <UINavigationControllerDelegate>
@property (nonatomic, weak) IBOutlet UINavigationController *navigationController;
@property (nonatomic, weak) UIPercentDrivenInteractiveTransition *interactiveTranstion;
@end
