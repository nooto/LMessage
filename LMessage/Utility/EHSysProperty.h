/*### WS@H Project:EHouse ###*/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EHSysProperty.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

#define APP_CORE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CURRENT_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEMVerSion [EHSysProperty getSystemVersion]
//#define ColorFromString(x) [EHSysProperty colorFromColorString:x]
#define ColorFromHex(x) [UIColor colorWithRed:(((x>>16)&0xFF) / 255.0f) green:(((x>>8)&0xFF) / 255.0f) blue:(((x)&0xFF) / 255.0f) alpha:1.0]
#define ColorFromHexRGBA(x) [UIColor colorWithRed:(((x>>24)&0xFF) / 255.0f) green:(((x>>16)&0xFF) / 255.0f) blue:(((x>>8)&0xFF) / 255.0f) alpha:(((x)&0xFF) / 255.0f)]


typedef enum
{
    IPHONE,
    IPAD
} DEVICETYPE;

@interface EHSysProperty : NSObject

+ (float)getSystemVersion;
+ (CGSize)getScreenSize;
+ (float)getNavBarHight;

+ (void)getCurrentLocale;
+ (void)getCurrentLocaleLanguage;
+ (void)getCurrentLanguage;

//+ (void)checkAppUpdateWithMiniVersion:(NSString *)iosMiniVersion;

//+ (UIColor *) colorFromColorString:(NSString *)colorString;
+ (UIColor *)colorFromColorString:(NSString *)colorString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (CGFloat)adjustGapW:(CGFloat)gap;
+ (CGFloat)adjustGapH:(CGFloat)gap;
+ (NSString *)getHardWardVersion;
@end
