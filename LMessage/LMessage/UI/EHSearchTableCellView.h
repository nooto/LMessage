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
@interface EHSearchTableCellView : UITableViewCell
@property (nonatomic, assign) NSInteger  showType; //0: 收起  1：展开
@property (nonatomic, copy) void(^didSelectAddPOI)(AMapPOI*);
@property (nonatomic, weak) AMapPOI *mapPOI;
-(void)loardMapPOI:(AMapPOI *)mapPOI showType:(NSInteger)type;
@end
