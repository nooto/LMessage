//
//  CircleTransitionAnimator.h
//  LMessage
//
//  Created by GaoAng on 16/4/18.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
//weak?var?transitionContext:?UIViewControllerContextTransitioning?
@property (nonatomic, weak)  id<UIViewControllerContextTransitioning> transitionContext;

@end
