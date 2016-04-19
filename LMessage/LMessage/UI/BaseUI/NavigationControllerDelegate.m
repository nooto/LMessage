//
//  NavigationControllerDelegate.m
//  LMessage
//
//  Created by GaoAng on 16/4/18.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"
@implementation NavigationControllerDelegate

-(void)awakeFromNib{
    UIPanGestureRecognizer *anGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:anGesture];
}

-(void)panned:(UIPanGestureRecognizer*)sender{
//    /1
//    @IBAction?func?panned(gestureRecognizer:?UIPanGestureRecognizer)?{
//        ??switch?gestureRecognizer.state?{
//            ??case?.Began:
//            ????self.interactionController?=?UIPercentDrivenInteractiveTransition()
//            ????if?self.navigationController?.viewControllers.count?>?1?{
//                ??????self.navigationController?.popViewControllerAnimated(true)
//                ????}?else?{
//                    ??????self.navigationController?.topViewController.performSegueWithIdentifier("PushSegue",?sender:?nil)
//                    ????}
//            ?
//            ????//2
//            ??case?.Changed:
//            ????var?translation?=?gestureRecognizer.translationInView(self.navigationController!.view)
//            ????var?completionProgress?=?translation.x/CGRectGetWidth(self.navigationController!.view.bounds)
//            ????self.interactionController?.updateInteractiveTransition(completionProgress)
//            ?
//            ????//3
//            ??case?.Ended:
//            ????if?(gestureRecognizer.velocityInView(self.navigationController!.view).x?>?0)?{
//                ??????self.interactionController?.finishInteractiveTransition()
//                ????}?else?{
//                    ??????self.interactionController?.cancelInteractiveTransition()
//                    ????}
//            ????self.interactionController?=?nil
//            ?
//            ????//4
//            ??default:
//            ????self.interactionController?.cancelInteractiveTransition()
//            ????self.interactionController?=?nil
//            ??}
//    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{
//            self.interactiveTranstion = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (self.navigationController.viewControllers.count) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [self.navigationController.topViewController performSegueWithIdentifier:@"PushSegue" sender:nil];
            }
        }
            
            break;
            
        case UIGestureRecognizerStateChanged:{
            
        }
            return;
        case UIGestureRecognizerStateEnded:{
            
        }
            return;
            
        default:
            break;
    }
}



- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC{
    
    return [[CircleTransitionAnimator alloc] init];
}

//var?interactionController:?UIPercentDrivenInteractiveTransition?
//?
//func?navigationController(navigationController:?UINavigationController,?
//                          interactionControllerForAnimationController?animationController:?UIViewControllerAnimatedTransitioning)?->?UIViewControllerInteractiveTransitioning??{
//    ??return?self.interactionController
//}


- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    return self.interactiveTranstion;
}


@end
