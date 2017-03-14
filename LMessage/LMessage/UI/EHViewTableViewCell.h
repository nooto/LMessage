//
//  EHViewTableViewCell.h
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHLocationData.h"
#import "MGSwipeTableCell.h"
@interface EHViewTableViewCell : MGSwipeTableCell
@property (nonatomic, copy) void (^didLongPress)(EHLocationData* locationData);

- (void)loardTableCellWithLocationData:(EHLocationData*)locationData curPostion:(CLLocationCoordinate2D)locationCoord;
@end
