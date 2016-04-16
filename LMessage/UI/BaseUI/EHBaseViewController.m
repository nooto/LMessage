/*### WS@H Project:EHouse ###*/

//  ViewController.m
//  EHouse
//
//  Created by admin on 15/3/12.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHBaseViewController.h"
#import "Font_Color.h"
@interface EHBaseViewController ()<EHCustomNavBarDelegate>

@property (nonatomic, strong)MBProgressHUD *progressHUD;
@end

@implementation EHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_BackGroundAuxiliary;
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.mNavBarView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    [bgView setBackgroundColor:Color_BackGroundAuxiliary];
    [self.view addSubview:bgView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.mNavBarView];
}

//-(void)pushViewController:(UIViewController*)vc{
//    if ([[RootNavigation.viewControllers lastObject] isKindOfClass:[EHCenterCtrlUpGradeView class]]) {
//        return;
//    }
//    
//    [RootNavigation pushViewController:vc animated:YES];
//}
//
//-(void)pushViewControllerNoAnimated:(UIViewController*)vc{
//    [RootNavigation pushViewController:vc animated:NO];
//}
//
//-(void)popViewControllerNoAnimated{
//    [RootNavigation popViewControllerAnimated:NO];
//}
//-(void)popViewControllerAnimated{
//    [RootNavigation popViewControllerAnimated:YES];
//}
//-(void)popToRootViewControllerAnimated{
//    [RootNavigation popToRootViewControllerAnimated:YES];
//}
//
//-(void)popToRootViewControllerNoAnimated{
//    [RootNavigation popToRootViewControllerAnimated:NO];
//}

- (void)addNewDevicesFinish{
    
}

/*
-(void)setTitle:(NSString *)title{
   
    [super setTitle:title];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/4, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
}*/

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.minSize = CGSizeMake(120, 120);
        _progressHUD.minShowTime = 1;
        // The sample image is based on the
        // work by: http://www.pixelpressicons.com
        // licence: http://creativecommons.org/licenses/by/2.5/ca/
        self.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MWPhotoBrowser.bundle/images/Checkmark.png"]];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)showProgressHUDWithMessage:(NSString *)message {
    self.progressHUD.labelText = message;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.progressHUD show:YES];
//    self.progressHUD.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)showProgressHUDWithMessage:(NSString *)message superView:(UIView *)superView
{
    self.progressHUD.labelText = message;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.progressHUD show:YES];
    [superView addSubview:self.progressHUD];
}

- (void)hideProgressHUD:(BOOL)animated {
    [self.progressHUD hide:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)showProgressHUDCompleteMessage:(NSString *)message {
    if (message) {
        if (self.progressHUD.isHidden) [self.progressHUD show:YES];
        self.progressHUD.labelText = message;
        self.progressHUD.mode = MBProgressHUDModeCustomView;
        [self.progressHUD hide:YES afterDelay:2];
    } else {
        [self.progressHUD hide:YES];
    }
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)addHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide{
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    MBProgressHUD *localHud = [[MBProgressHUD alloc] initWithView: [UIApplication sharedApplication].keyWindow];
    if (labelText && labelText.length > 0) {
        localHud.detailsLabelText = labelText;
    }
    else{
        localHud.detailsLabelText = NSLocalizedString(@"Loading", nil);
    }
    localHud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    if (hide) {
        localHud.removeFromSuperViewOnHide = hide;
        localHud.mode = MBProgressHUDModeText;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview: localHud];
    [localHud show:YES];
    
    if (hide) {
        [localHud hide:hide afterDelay:2.0f];
    }
    
    _progressHUD = localHud;
}

- (void)addHorizontalHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide
{
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    MBProgressHUD *localHud = [[MBProgressHUD alloc] initWithView: [UIApplication sharedApplication].keyWindow];
    if (labelText && labelText.length > 0) {
        localHud.detailsLabelText = labelText;
    }
    else{
        localHud.detailsLabelText = NSLocalizedString(@"Loading", nil);
    }
    localHud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    
    if (hide) {
        localHud.removeFromSuperViewOnHide = hide;
        localHud.mode = MBProgressHUDModeText;
    }
    
    //  HUD.labelFont = [UIFont fontWithName:@"System Blod" size:16];
    [[UIApplication sharedApplication].keyWindow addSubview: localHud];
    [localHud show:YES];
    
    if (hide) {
        [localHud hide:hide afterDelay:2.0f];
    }
    
    localHud.transform = CGAffineTransformMakeRotation(M_PI/2);
    _progressHUD = localHud;
}

- (void)addHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide ToView:(BOOL)yes{
    [_progressHUD hide:YES];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
    MBProgressHUD *localHud = [[MBProgressHUD alloc] initWithView: [UIApplication sharedApplication].keyWindow];
    localHud.detailsLabelText = NSLocalizedString(@"Loading", nil);
    localHud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    if (hide) {
        localHud.removeFromSuperViewOnHide = hide;
        localHud.detailsLabelText = labelText;
        localHud.mode = MBProgressHUDModeText;
    }
    if (yes) {
        [self.navigationController.view addSubview:localHud];
    }
    else{
        [[UIApplication sharedApplication].keyWindow addSubview: localHud];
    }
    [localHud show:YES];
    if (hide) {
        [localHud hide:hide afterDelay:2.0f];
    }
    
    _progressHUD = localHud;
}

-(BOOL)checkNetWork{
//    if (![AFNetworkReachabilityManager sharedManager].reachable)
//    {
//        [self addHudWithText:NSLocalizedString(@"Oops,unable to connect", nil) HideAfterDelay:YES];
//        return NO;
//    }
    return YES;
}

- (void)removeHUD{
    [_progressHUD removeFromSuperview];
    _progressHUD = nil;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)closeKeyBoard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    NSLog(@"让我旋转哪些方向1");
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    NSLog(@"让我旋转哪些方向2");
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

//
-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.mNavBarView setTitle:title];
}

-(EHCustomNavBar*)mNavBarView{
    if (!_mNavBarView) {
        _mNavBarView = [[EHCustomNavBar alloc] initWithdelegate:self];
    }
    return _mNavBarView;
}

- (void)backBtnPressed:(UIButton *)sender {
    [self popViewControllerAnimated];
}

-(void)addRightButton:(UIButton *)button{
    if (button) {
        [self.mNavBarView addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.titleLabel.font = self.mNavBarView.mTextLabel.font;
        button.center = CGPointMake(SCREEN_W - MarginW(20) - CGRectGetWidth(button.frame)/2, self.mNavBarView.mTextLabel.center.y);
    }
}

-(void)hiddeBackButton{
    self.mNavBarView.mLeftButton.hidden = YES;
}
-(void)showBackButton{
    self.mNavBarView.mLeftButton.hidden = NO;
}
-(void)setBackButtonImage:(UIImage *)image{
    [self.mNavBarView.mLeftButton setImage:image forState:UIControlStateNormal];
}

-(void)setBackButtonText:(NSString *)text{
    [self.mNavBarView.mLeftButton setTitle:text forState:UIControlStateNormal];
}

-(BOOL)checkTopViewController{
//    if ([[RootNavigation.viewControllers lastObject] isKindOfClass:[self class]]) {
//        return YES;
//    }
    return NO;
}

@end
