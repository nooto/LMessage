//
//  EHLocationData.m
//  LMessage
//
//  Created by GaoAng on 16/5/31.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHLocationData.h"
#define STR_locationName @"locationName"
@implementation EHLocationData
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.locationName = [aDecoder decodeObjectForKey:STR_locationName];
    }
    return self;
}
-(id)initWithAMapPOI:(AMapPOI *)mapPOI{
    if (self = [super init]) {
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.locationName forKey:STR_locationName];
}

-(void)paresMapPOI:(AMapPOI*)mapPOI{
    self.locationName = mapPOI.name;
    self.address = mapPOI.address;
    self.locationCoordinate = CLLocationCoordinate2DMake(mapPOI.location.latitude, mapPOI.location.longitude);
    
}

@end
