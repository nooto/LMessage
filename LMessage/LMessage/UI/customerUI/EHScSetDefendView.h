/*### WS@H Project:EHouse ###*/
//
//  EHScSetDefendView.h
//  EHouse
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHScSetDefendView : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *lastColor;
-(id)initWithFrame:(CGRect)frame arr:(NSArray*)arrData;
-(void)showModifyNamePageView;
@property (nonatomic, strong) void (^didSelectIndex)(NSInteger index);
@property (nonatomic, strong) void (^didSelectIndexWithText)(NSInteger index, NSString *indexText);
-(void)setCellWithImage:(UIImage *)image index:(NSInteger)index;
@end
