//
//  NSString+hex.m
//  iCoAP
//
//  Created by Wojtek Kordylewski on 15.06.13.

#import "NSString+hex.h"

@implementation NSString (hex)

+ (NSString *)hexStringFromString:(NSString *) string {
    
    const char *p = [string cStringUsingEncoding:NSUTF8StringEncoding];
    return [self stringFromDataWithHex:[NSData dataWithBytes:p length:strlen(p)]];
}

+ (NSString *)stringFromHexString:(NSString *) string {
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [string length] / 2; i++) {
        NSString * hexByte = [string substringWithRange: NSMakeRange(i * 2, 2)];
        int charResult = 0;
        sscanf([hexByte cStringUsingEncoding:NSUTF8StringEncoding], "%x", &charResult);
        [result appendFormat:@"%c", charResult];
    }
    return result;
}

+ (char *)cStringFromHexString:(NSString *)string length:(uint *)length{
    *length = (uint)string.length/2+2;
    char *p = malloc(*length);
    if (NULL == p) {
        return NULL;
    }
    memset(p, 0, *length);
    *length = *length-2;
    for (int i = 0; i < *length; i++) {
        NSString * hexByte = [string substringWithRange: NSMakeRange(i * 2, 2)];
        int charResult = 0;
        sscanf([hexByte cStringUsingEncoding:NSUTF8StringEncoding], "%x", &charResult);
        p[i] = charResult;
//        printf("\n%02d = ",i);
//        printf("%c",charResult);
    }
    return p;
}

+ (NSString *)stringFromDataWithHex:(NSData *)data{
    NSString *result = [[data description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result substringWithRange:NSMakeRange(1, [result length] - 2)];
    return result;
}

+ (NSString *)get0To4ByteHexStringFromInt:(int32_t)value {
    NSString *valueString;
    if (value == 0) {
        valueString = @"";
    }
    else if (value < 255) {
        valueString = [NSString stringWithFormat:@"%02X", value];
    }
    else if (value <= 65535) {
        valueString = [NSString stringWithFormat:@"%04X", value];
    }
    else if (value <= 16777215) {
        valueString = [NSString stringWithFormat:@"%06X", value];
    }
    else {
        valueString = [NSString stringWithFormat:@"%08X", value];
    }
    return valueString;    
}

@end
