//
//  NSDictionary+Category.h
//  EHouse
//
//  Created by GaoAng on 15/5/26.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary_Category)

-(NSString*)stringWithKey:(NSString*)key;
-(NSInteger)integerWithKey:(NSString*)key;
-(float)floatWithKey:(NSString*)key;
-(BOOL)boolValueWithKey:(NSString*)key;
@end
