//
//  EHLocationData.h
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHBaseObject.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface EHLocationData : EHBaseObject
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;
- (id)initWithAMapPOI:(AMapPOI*)mapPOI;
-(BOOL)isEqualToMapPoi:(AMapPOI*)mapPOI;
@end
