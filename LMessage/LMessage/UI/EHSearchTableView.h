//
//  EHSearchTableView.h
//  LMessage
//
//  Created by GaoAng on 16/6/16.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@protocol EHSearchTableViewDelegate<NSObject>
-(NSArray*)seachTableViewSourceDatas;
- (void)didSelectAMAPPOI:(AMapPOI*)mapPOI;
- (void)didSelectAddAMAPPOI:(AMapPOI*)mapPOI indexPath:(NSIndexPath*)indexPath;
@end

@interface EHSearchTableView : UITableView
@property (nonatomic, assign) NSInteger  showDetailViewIndex;
-(id)initWithFrame:(CGRect)frame withDelegate:(id)delegate;
- (void)reloadTableViewWithIndexPath:(NSIndexPath*)indexPath;
@end
