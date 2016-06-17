//
//  EHLocationDataManager.h
//  LMessage
//
//  Created by GaoAng on 16/6/7.
//  Copyright © 2016年 GaoAng. All rights reserved.
//

#import "EHBaseObject.h"
#import "EHLocationData.h"
@interface EHLocationDataManager : EHBaseObject
@property (nonatomic, strong) NSMutableArray *mLocationDatas;

+(EHLocationDataManager*)shareInstance;
-(void)addMLocationData:(EHLocationData*)locationData;
-(void)removeMLocationData:(EHLocationData*)locationData;
@end

#define LocationDataManager [EHLocationDataManager shareInstance]

