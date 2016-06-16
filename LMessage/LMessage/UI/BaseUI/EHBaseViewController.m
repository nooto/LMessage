/*### WS@H Project:EHouse ###*/

//  ViewController.m
//  EHouse
//
//  Created by admin on 15/3/12.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "EHBaseViewController.h"
#import "Font_Color.h"
@interface EHBaseViewController ()

@property (nonatomic, strong)MBProgressHUD *progressHUD;

@end

@implementation EHBaseViewController



#pragma mark - 联网标记。。
- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView: [UIApplication sharedApplication].keyWindow];
        _progressHUD.minSize = CGSizeMake(120, 120);
        _progressHUD.minShowTime = 1;
        _progressHUD.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
        _progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MWPhotoBrowser.bundle/images/Checkmark.png"]];
    }
    return _progressHUD;
}

- (void)addHudWithText:(NSString *)labelText HideAfterDelay:(BOOL)hide{
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    if (labelText && labelText.length > 0) {
        self.progressHUD.detailsLabelText = labelText;
    }
    else{
        self.progressHUD.detailsLabelText = NSLocalizedString(@"Loading", nil);
    }
    
    if (hide) {
        self.progressHUD.removeFromSuperViewOnHide = hide;
        self.progressHUD.mode = MBProgressHUDModeText;
        [self.progressHUD hide:hide afterDelay:3.0f];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview: self.progressHUD];
    [self.progressHUD show:YES];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.mNavBarView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *uivew = [[UIView alloc] init];
    [self.view addSubview:uivew];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)removeHUD{
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}
#pragma mark - 
-(void)pushViewController:(UIViewController*)vc{
    [RootNavigation pushViewController:vc animated:YES];

}

-(void)pushViewControllerNoAnimated:(UIViewController*)vc{
    [RootNavigation pushViewController:vc animated:NO];
}

-(void)popViewControllerNoAnimated{
//    [RootNavigation dismissViewControllerAnimated:<#(BOOL)#> completion:<#^(void)completion#>]
    [RootNavigation popViewControllerAnimated:NO];
}

-(void)popViewControllerAnimated{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popToRootViewControllerAnimated{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popToRootViewControllerNoAnimated{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - 基础功能方法
- (void)closeKeyBoard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

//旋转控制。。
- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
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
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -MarginH(10), 0, MarginH(10));
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -MarginH(10), 0, MarginH(10));
        button.center = CGPointMake(SCREEN_W - CGRectGetWidth(button.frame)/2, self.mNavBarView.mTextLabel.center.y);
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
    return NO;
}


@end
