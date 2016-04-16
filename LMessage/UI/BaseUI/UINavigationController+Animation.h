/*### WS@H Project:EHouse ###*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    CustomViewAnimationTransitionNone,
    CustomViewAnimationTransitionFlipFromLeft,
    CustomViewAnimationTransitionFlipFromRight,
    CustomViewAnimationTransitionCurlUp,
    CustomViewAnimationTransitionCurlDown,
    CustomViewAnimationTransitionFadeIn,
    CustomViewAnimationTransitionMoveIn,
    CustomViewAnimationTransitionPush,
    CustomViewAnimationTransitionReveal
} CustomViewAnimationTransition;

#define CustomViewAnimationSubtypeFromRight kCATransitionFromRight
#define CustomViewAnimationSubtypeFromLeft kCATransitionFromLeft
#define CustomViewAnimationSubtypeFromTop kCATransitionFromTop
#define CustomViewAnimationSubtypeFromBottom kCATransitionFromBottom

@interface UINavigationController(animation)

- (void)pushViewController:(UIViewController *)viewController withCustomTransition:(CustomViewAnimationTransition)transition subtype:(NSString*)subtype;
- (void)popViewControllerWithCustomTransition:(CustomViewAnimationTransition)transition subtype:(NSString*)subtype;
- (void)popToRootViewControllerWithCustomTransition:(CustomViewAnimationTransition)transition subtype:(NSString*)subtype;
- (void)popToViewController:(UIViewController *)viewController withCustomTransition:(CustomViewAnimationTransition)transition subtype:(NSString*)subtype;

@end