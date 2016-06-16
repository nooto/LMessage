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
- (void)didSelectAddAMAPPOI:(AMapPOI*)mapPOI;
@end

@interface EHSearchTableView : UITableView
-(id)initWithFrame:(CGRect)frame withDelegate:(id)delegate;
@end
