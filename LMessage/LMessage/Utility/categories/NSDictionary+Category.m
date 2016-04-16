//
//  NSDictionary+Category.m
//  EHouse
//
//  Created by GaoAng on 15/5/26.
//  Copyright (c) 2015年 wondershare. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (NSDictionary_Category)

-(NSString*)stringWithKey:(NSString*)key{
    id value = self[key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    return nil;
}

-(NSInteger)integerWithKey:(NSString*)key{
    id value = self[key];
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    
    return -1;
}

-(float)floatWithKey:(NSString*)key{
    id value = self[key];
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    
    return -1;
}

-(BOOL)boolValueWithKey:(NSString*)key{
    id value = self[key];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    
    return NO;
}


@end
