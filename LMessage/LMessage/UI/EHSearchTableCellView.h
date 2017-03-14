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
@property (nonatomic, copy) void(^didSelectAddPOI)(AMapPOI*);
@property (nonatomic, assign) BOOL  isContained;; //是否已经收藏

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)cellHeight;
-(void)loardMapPOI:(AMapPOI *)mapPOI showType:(NSInteger)type;
@end
