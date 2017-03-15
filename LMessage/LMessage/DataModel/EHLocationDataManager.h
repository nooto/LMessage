//
//  EHLocationDataManager.h
//  LMessage
//
//  Created by GaoAng on 16/6/7.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHBaseObject.h"
#import "EHLocationData.h"
#import <MAMapKit/MAPointAnnotation.h>
@interface EHLocationDataManager : EHBaseObject
@property (nonatomic, strong) NSMutableArray *mLocationDatas;
@property (nonatomic, strong) CLLocation *mLocation;  //用户当前的位置ID

+(EHLocationDataManager*)shareInstance;
-(void)saveLocationDatas;
-(void)addMLocationData:(EHLocationData*)locationData;
-(void)removeMLocationData:(EHLocationData*)locationData;

-(BOOL)containMLocationData:(AMapPOI*)mapPOI;

-(NSArray*)createArrOfPointAnnotation;

@end

#define LocationDataManager [EHLocationDataManager shareInstance]

