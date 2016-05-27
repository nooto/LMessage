//
//  CircleTransitionAnimator.m
//  LMessage
//
//  Created by GaoAng on 16/4/18.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "CircleTransitionAnimator.h"

@implementation CircleTransitionAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIBarButtonItem *button = [fromViewController editButtonItem];
    
//    =?transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?as!?ViewController
//        ??var?toViewController?=?transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?as!?ViewController
//        ??var?button?=?fromViewController.button
//        ?
//        ??//3
    
    [containerView addSubview:toViewController.view];
    
//        ??containerView.addSubview(toViewController.view)
//        ?
//        ??//4
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithRect:button.customView.frame];
//        ??var?extremePoint?=?CGPoint(x:?button.center.x?-?0,?y:?button.center.y?-?CGRectGetHeight(toViewController.view.bounds))
//        ??var?radius?=?sqrt((extremePoint.x*extremePoint.x)?+?(extremePoint.y*extremePoint.y))
//        ??var?circleMaskPathFinal?=?UIBezierPath(ovalInRect:?CGRectInset(button.frame,?-radius,?-radius))
//        ?
//        ??//5
//        ??var?maskLayer?=?CAShapeLayer()
//        ??maskLayer.path?=?circleMaskPathFinal.CGPath
//        ??toViewController.view.layer.mask?=?maskLayer
//        ?
//        ??//6
//        ??var?maskLayerAnimation?=?CABasicAnimation(keyPath:?"path")
//        ??maskLayerAnimation.fromValue?=?circleMaskPathInitial.CGPath
//        ??maskLayerAnimation.toValue?=?circleMaskPathFinal.CGPath
//        ??maskLayerAnimation.duration?=?self.transitionDuration(transitionContext)
//        ??maskLayerAnimation.delegate?=?self
//        ??maskLayer.addAnimation(maskLayerAnimation,?forKey:?"path")
//    }
    
    CGPoint extremePoint = CGPointMake(button.customView.center.x - 70, button.customView.center.y - CGRectGetHeight(toViewController.view.bounds));
    CGFloat radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.x*extremePoint.y);
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithRect:CGRectInset(button.customView.frame, -radius, -radius)];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = masklayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)([circleMaskPathFinal CGPath]);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [masklayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

//override?func?animationDidStop(anim:?CAAnimation!,?finished?flag:?Bool)?{
//    ??self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
//    ??self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask?=?nil
//}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:[self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:@"UITransitionContextFromViewControllerKey"].view.layer.mask = nil;
}

@end
