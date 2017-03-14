//
//  EHLocationData.m
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHLocationData.h"
#import <objc/runtime.h>
#define STR_locationName @"locationName"
#define STR_address @"address"
#define STR_latitude @"latitude"
#define STR_longitude @"longitude"
@implementation EHLocationData
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        self.locationName = [aDecoder decodeObjectForKey:STR_locationName];
        self.address = [aDecoder decodeObjectForKey:STR_address];
        
        CLLocationDegrees  latitude = [[aDecoder decodeObjectForKey:@""] doubleValue];
        CLLocationDegrees  longitude = [[aDecoder decodeObjectForKey:@""] doubleValue];
        self.locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    return self;
}
-(id)initWithAMapPOI:(AMapPOI *)mapPOI{
    if (self = [super init]) {
        [self paresMapPOI:mapPOI];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.locationName forKey:STR_locationName];
    [aCoder encodeObject:self.address forKey:STR_address];
    
    [aCoder encodeObject:@(self.locationCoordinate.latitude) forKey:STR_latitude];
    [aCoder encodeObject:@(self.locationCoordinate.longitude) forKey:STR_longitude];
}

-(void)paresMapPOI:(AMapPOI*)mapPOI{
    self.locationName = mapPOI.name;
    self.address = mapPOI.address;
    self.locationCoordinate = CLLocationCoordinate2DMake(mapPOI.location.latitude, mapPOI.location.longitude);
}

-(BOOL)isEqualToMapPoi:(AMapPOI*)mapPOI{
    CGFloat  gap = 5.0f;
    CGFloat lognGap = fabs(mapPOI.location.longitude  - self.locationCoordinate.longitude);
    CGFloat latitudeGap = fabs(mapPOI.location.latitude  - self.locationCoordinate.latitude);

    NSLog(@"mapPOI: ---------%f ------- %f  ", mapPOI.location.longitude , mapPOI.location.latitude );
    NSLog(@"mapPOI: ---------%@ ------- %@  ", mapPOI.address , mapPOI.name );


    NSLog(@"locationData: -------%f -------- %f  ", self.locationCoordinate.longitude, self.locationCoordinate.latitude);
    NSLog(@"locationData: -------%@ -------- %@  ", self.locationName, self.address);

    NSLog(@"gap:  ---------%f ------ %f  ", lognGap, latitudeGap);
    NSLog(@"gap:  ---------%f ------ %f  ", lognGap, latitudeGap);

    if ([self.locationName isEqualToString:mapPOI.name]) {
        if ([self.address isEqualToString:mapPOI.address]) {
            if (lognGap <= gap && latitudeGap <= gap) {
                return YES;
            }
            return YES;
        }
    }

    return NO;
}


@end
