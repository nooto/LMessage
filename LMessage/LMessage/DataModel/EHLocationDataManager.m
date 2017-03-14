//
//  EHLocationDataManager.m
//  LMessage
//
//  Created by GaoAng on 16/6/7.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#define KUserDefaultLocationKey @"NSUserDefaultsLocationDatas"
#import "EHLocationDataManager.h"

__strong static EHLocationDataManager *shareInstance = nil;
@implementation EHLocationDataManager

+(EHLocationDataManager*)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[EHLocationDataManager alloc] init];
        [shareInstance loardFromeUser];
    });
    return shareInstance;
}

-(void)loardFromeUser{
    NSData *date = [[NSUserDefaults standardUserDefaults] objectForKey:KUserDefaultLocationKey];
    self.mLocationDatas  = [NSKeyedUnarchiver unarchiveObjectWithData:date];
}

-(void)saveLocationDatas{
    if (self.mLocationDatas.count > 0) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self.mLocationDatas];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:KUserDefaultLocationKey];
    }
    else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserDefaultLocationKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)addMLocationData:(EHLocationData*)locationData{
    if (!locationData) {
        return;
    }
    for (EHLocationData *tempData in self.mLocationDatas) {
        if ([tempData isEqual:locationData]) {
            return;
        }
    }
    [self.mLocationDatas addObject:locationData];
    [self saveLocationDatas];
    
}

-(void)removeMLocationData:(EHLocationData *)locationData{
    if (self.mLocationDatas) {
        if ([self.mLocationDatas containsObject:locationData]) {
            [self.mLocationDatas removeObject:locationData];
            [self saveLocationDatas];
        }
    }
}

-(BOOL)containMLocationData:(AMapPOI*)mapPOI{
    CGFloat  gap = 5.0f;
    for (NSInteger i = 0 ; i < self.mLocationDatas.count; i ++) {
        EHLocationData *locationData = self.mLocationDatas[i];
        CGFloat lognGap = fabs(mapPOI.location.longitude  - locationData.locationCoordinate.longitude);
        CGFloat latitudeGap = fabs(mapPOI.location.latitude  - locationData.locationCoordinate.latitude);

        NSLog(@"mapPOI: %f  %f  ", mapPOI.location.longitude , mapPOI.location.latitude );
        NSLog(@"locationData: %f  %f  ", locationData.locationCoordinate.longitude, locationData.locationCoordinate.latitude);
        NSLog(@"gap:  %f  %f  ", lognGap, latitudeGap);

        if (lognGap <= gap && latitudeGap <= gap) {
            return YES;
        }
    }

    return NO;
}

-(NSMutableArray*)mLocationDatas{
    if (!_mLocationDatas) {
        _mLocationDatas = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _mLocationDatas;
}

@end
