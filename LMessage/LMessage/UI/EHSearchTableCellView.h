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
@property (nonatomic, copy) void(^didSelectAddPOI)(AMapPOI*);
@property (nonatomic, weak) AMapPOI *mapPOI;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellHeight:(CGFloat)cellHeight;
-(void)loardMapPOI:(AMapPOI *)mapPOI showType:(NSInteger)type;
@end
