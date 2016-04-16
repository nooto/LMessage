//
//  NSString+HCTAvailableString.h
//  HomeCtrl
//
//  Created by user on 15/1/29.
//  Copyright (c) 2015年 1719. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HCTAvailableString)
+ (NSUInteger)returnProductIDLocation:(NSString *)string;
+ (BOOL)isAvailableQRResultString:(NSString *)string;

+ (NSString*)stringWithDict:(NSDictionary*)dict key:(NSString*)key;
+ (NSString*)stringFromDeviceType:(NSString *)DeviceType;
@end


@interface NSString(Utils)

- (NSString *)getMd5_32Bit_String;
- (BOOL) isValidateNumber;
- (BOOL) isValidateP2PVerifyCode1OrP2PVerifyCode2;

@end
