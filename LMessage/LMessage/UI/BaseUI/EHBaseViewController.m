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

@end
