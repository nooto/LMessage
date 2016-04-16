/*### WS@H Project:EHouse ###*/


#import "EHSysProperty.h"
#import "EHSysScreen.h"
#import "AppDelegate.h"

#import <math.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import <sys/utsname.h>

enum {
    // iPhone 1G,3G,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    
    // iPhone 4,4S, iPod Touch 1 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    
    // iPhone 5,iPod Touch 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    
    // iPad 1,2 ,iPad Mini 1 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    
    // iPad 3,4 ,iPad Air,iPad Mini 2 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;


@implementation EHSysProperty

+ (float)getSystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
    
}

+ (CGSize)getScreenSize{
    UIScreen *screen = [UIScreen mainScreen];
    return screen.currentMode.size;
}

+ (float)getNavBarHight{
    //    UINavigationBar *bar = [RootNavigation navigationBar];
    
    //    if (bar.frame.size.height <= 0.0) {
    if ([EHSysProperty getSystemVersion] >= 7.0) {
        return 64;
    }
    else{
        return 44;
    }
    //    }
    //    else{
    //        return bar.frame.size.height;
    //    }
}

+ (void)getCurrentLocale{
    // 当前所在地信息
    NSString *identifier = [[NSLocale currentLocale] localeIdentifier];
    NSString *displayName = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:identifier];
}

+ (void)getCurrentLocaleLanguage{
    // 当前所在地的使用语言
    NSLocale *currentLocale = [NSLocale currentLocale];
}

+ (void)getCurrentLanguage
{
    //    当前使用的语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    // 系统所支持的语言
    //    NSArray *arLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    //    NSString *strLang = [arLanguages objectAtIndex:0];
    //    NSLog(@"LANG:%@",strLang);
}

// check the input string is empty
+ (BOOL)isEmptyString:(NSString *)str
{
    return (nil == str) || (str.length == 0);
}

// get the platform type
+ (NSString *)getPID
{
    return [[UIDevice currentDevice] model];
}

+ (DEVICETYPE)getDeviceType
{
    NSRange reage=[[[self class] getPID] rangeOfString:@"ipad" options:NSCaseInsensitiveSearch];
    if(reage.location != NSNotFound)
    {
        return IPAD;
    }
    
    return IPHONE;
}

// get the sdk version
+ (NSString *)getSDKVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

// get the ScreenResolution
+ (CGSize)getScreenResolution
{
    return [[UIScreen mainScreen] currentMode].size;
}

// get the ScreenDensity
+ (NSString *)getScreenDensity
{
    CGSize size = [[self class] getScreenResolution];
    float lPpi = sqrtf(powf(size.width, 2) + powf(size.height, 2))/ ([[self class] getDeviceType] == IPAD ? 9.7 :(size.height == 1136 ? 4 : 3.5));
    
    return [[NSNumber numberWithInt:(int)lPpi] stringValue];
}

/*
 + (void)checkAppUpdateWithMiniVersion:(NSString *)iosMiniVersion {
 static BOOL isAppUpdate = NO;
 
 //检测程序是否需要升级
 if (iosMiniVersion) {
 NSComparisonResult result = [iosMiniVersion compare:APP_CORE_VERSION];
 if (result == NSOrderedDescending) {
 if (!isAppUpdate) {
 isAppUpdate = YES;
 // 升级监测
 [[Harpy sharedInstance] checkNewVersionInAppStoreWithCompletedCallback:^(NSError *err, NSString *appStoreVersion, NSURL *storeURL) {
 if (!err && appStoreVersion && storeURL){
 UIAlertView *alert = [[UIAlertView alloc]
 initWithTitle: NSLocalizedString(@"Hint", nil)
 message: NSLocalizedString(@"Product need the latest app version, update or not?", nil)
 delegate: [UIApplication sharedApplication].delegate
 cancelButtonTitle: NSLocalizedString(@"Cancel", nil)
 otherButtonTitles: NSLocalizedString(@"Download updates", nil), nil];
 //                        alert.tag = APP_UPGRADE_ALERTVIEW_TAG;
 [alert show];
 }
 isAppUpdate = NO;
 }];
 }
 }
 }
 }
 //*/

+ (UIColor *) colorFromColorString:(NSString *)colorString{
    return [EHSysProperty colorFromColorString:colorString alpha:1.0f];
}

+ (UIColor *)colorFromColorString:(NSString *)colorString alpha:(CGFloat)alpha{
    
    NSString *stringToConvert = @"";
    stringToConvert = [colorString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString rangeOfString:@","].location != NSNotFound) {
        NSArray *array = [colorString componentsSeparatedByString:@","];
        return [UIColor colorWithRed:([array[0] intValue]/255.0) green:([array[1] intValue]/255.0) blue:([array[2] intValue]/255.0) alpha:1.0];
    }
    
    if ([cString length] < 6)
        return [UIColor clearColor];
    
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] > 6)
        cString = [cString substringToIndex:6];
    
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:(blue / 255.0f) alpha:1.0f];
}

+ (CGFloat)adjustGapW:(CGFloat)gap{
    /*
     if (480 == SCREEN_H) {//4s及以前
     return gap;
     }
     else if (568 == SCREEN_H) {//5,5s,5s
     return gap;
     }
     else if (667 == SCREEN_H) {//6
     return gap * 1.17;
     }
     else if (736 == SCREEN_H) {//6p
     return gap * 1.17;
     }
     return gap;*/
    if (480 == SCREEN_H) {//4s及以前
        return gap *0.85;
    }
    else if (568 == SCREEN_H) {//5,5s,5s
        return gap *0.85;
    }
    else if (667 == SCREEN_H) {//6
        return gap;
    }
    else if (736 == SCREEN_H) {//6p
        return gap;
    }
    return gap;
}

+ (CGFloat)adjustGapH:(CGFloat)gap{
    /*
     if (480 == SCREEN_H) {//4s及以前
     return gap ;
     }
     else if (568 == SCREEN_H) {//5,5s,5s
     return gap ;
     }
     else if (667 == SCREEN_H) {//6
     return gap * 1.17;
     }
     else if (736 == SCREEN_H) {//6p
     return gap * 1.17;
     }
     return gap;
     */
    
    if (480 == SCREEN_H) {//4s及以前
        return gap *0.72;
    }
    else if (568 == SCREEN_H) {//5,5s,5s
        return gap *0.85;
    }
    else if (667 == SCREEN_H) {//6
        return gap;
    }
    else if (736 == SCREEN_H) {//6p
        return gap;
    }
    return gap;
}

+ (NSString *)getHardWardVersion{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    else if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    else if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    else if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    else if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    else if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    else if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    else if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    else if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    else if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    else if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    else if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    else if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    else if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    else if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    else if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s (A1633/A1688/A1700)";
    else if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus (A1634/A1687/A1699)";
    
    else if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    else if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    else if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    else if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    else if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    else if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    else if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    else if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    else if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    else if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    else if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    else if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    else if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    else if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    else if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    else if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    else if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    else if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    else if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    else if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    else if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    else if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    else if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    else if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    else if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    else if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    else if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

@end
