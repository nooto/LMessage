//
//  EHSearchTableCellView.h
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#define CellTopHeight  60
#define CellBottomHeight  120

@interface EHSearchTableCellView : UITableViewCell
@property (nonatomic, strong) UILabel *mNameLabel;
@property (nonatomic, strong) UILabel *mDetailLabel;
@property (nonatomic, strong) UIButton *mAddButtton;

@property (nonatomic, assign) NSInteger  showType; //0: 收起  1：展开

@property (nonatomic, weak) AMapPOI *mapPOI;


@property (nonatomic, copy) void(^didSelectAddPOI)(AMapPOI*);
@property (nonatomic, assign) BOOL  isContained;; //是否已经收藏

-(void)setupview;
@end
