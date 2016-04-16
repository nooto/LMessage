//
//  NSString+HCTAvailableString.m
//  HomeCtrl
//
//  Created by user on 15/1/29.
//  Copyright (c) 2015年 1719. All rights reserved.
//

#import "NSString+HCTAvailableString.h"


@implementation NSString (HCTAvailableString)

+ (NSUInteger)returnProductIDLocation:(NSString *)string {
    NSRange range = [string rangeOfString:@"ez_pro_id"];
    return range.location + range.length + 1;
}

+ (NSRange)returnProductIDRange:(NSString *)string {
    return [string rangeOfString:@"ez_pro_id"];
}

+ (BOOL)isAvailableQRResultString:(NSString *)string {
    NSUInteger prefixLength = [@"http://api.1719.com/download/app/" length];
    NSUInteger prefixProductID = [@"ez_pro_id" length];
    NSRange range = [string rangeOfString:@"http://api.1719.com/download/app/" options:NSCaseInsensitiveSearch];
    NSRange product_id_range = [self returnProductIDRange:string];
    if (range.length != prefixLength || range.location != prefixLength - range.length || product_id_range.length != prefixProductID || product_id_range.location != (prefixLength + 1)) {
        return NO;
    }
    return YES;
}

+ (NSString*)stringWithDict:(NSDictionary*)dict key:(NSString*)key{
    id value = [dict objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    else{
        return nil;
    }
}

+ (NSString*)stringFromDeviceType:(NSString *)DeviceType{
    if ([DeviceType isEqualToString:@"1000"]) {
        
    }
    if ([DeviceType isEqualToString:@"2000"]) {
        return @"智能门锁";
    }
    if ([DeviceType isEqualToString:@"2100"]) {
        return @"烟雾传感器";
    }
    if ([DeviceType isEqualToString:@"2101"]) {
        return @"红外检测";
    }
    if ([DeviceType isEqualToString:@"2102"]) {
        return @"水浸检测器";
    }
    if ([DeviceType isEqualToString:@"2103"]) {
        return @"SOS";
    }
    if ([DeviceType isEqualToString:@"2104"]) {
        return @"门磁感应";
    }
    if ([DeviceType isEqualToString:@"2200"]) {
        return @"温湿度";
    }
    if ([DeviceType isEqualToString:@"2201"]) {
        return @"光照检测";
    }
    if ([DeviceType isEqualToString:@"2300"]) {
    }
    if ([DeviceType isEqualToString:@"2200"]) {
        return @"智能开关";
    }
    if ([DeviceType isEqualToString:@"2400"]) {
        return @"智能插座";
    }
    
    return @"智能设备";
}

@end

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Utils)

- (NSString *)getMd5_32Bit_String{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result lowercaseString];
}


- (BOOL) isValidateNumber{
    const char *cvalue = [self UTF8String];
    int len = (int)strlen(cvalue);
    for (int i = 0; i < len; i++) {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9')) {
            return FALSE;
        }
    }
    return TRUE;
}

- (BOOL) isValidateP2PVerifyCode1OrP2PVerifyCode2{
    
    if ([self characterAtIndex:0] == '-') {//带“-”的codeStr1
        if(![[self substringFromIndex:1] isValidateNumber]){//有效的number
            return NO;
        }
    }else if (![self isValidateNumber]){//有效的number
        return NO;
    }
    
    unsigned  int verifyCode = (unsigned int)self.intValue;
    unsigned  int min = 0;
    unsigned  int max = (unsigned int)(pow(2.0,32) - 1);
    if (verifyCode < min || verifyCode > max){
        return NO;
    }
    
    return YES;
}

@end
