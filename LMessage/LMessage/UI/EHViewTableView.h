//
//  EHViewTableView.h
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeButton.h"
#import "EHLocationDataManager.h"
@interface EHViewTableView : UITableView
-(void)updateViewWithCLLocationCoordinate:(CLLocationCoordinate2D)locationCoord;
@end
