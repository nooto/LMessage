/*### WS@H Project:EHouse ###*/
//
//  EHCustomNavBar.h
//  EHouse
//
//  Created by GaoAng on 15/9/16.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHNavButton.h"

@protocol EHCustomNavBarDelegate <NSObject>
-(void)backBtnPressed:(UIButton*)button;
@end


@interface EHCustomNavBar : UIView

@property (nonatomic, copy) NSString *title;
//背景图片
@property (nonatomic, strong) UIImageView *mImageView;

//标题栏
@property (nonatomic, weak) UILabel *mTextLabel;


//左侧返回按钮。默认显示。
@property (nonatomic, strong ) EHNavButton *mLeftButton;
@property (nonatomic, assign)  id<EHCustomNavBarDelegate> m_delegate;

-(id)initWithdelegate:(id)delegate;



//
@end





