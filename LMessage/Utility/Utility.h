//
//  Utility.h
//  HomeCtrl
//
//  Created by zhong on 15/1/13.
//  Copyright (c) 2015年 1719. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHFKeychainUtils.h"

extern dispatch_queue_t easylinkQueue;
//extern dispatch_queue_t luaQueue;
extern dispatch_queue_t sendQueue;
extern dispatch_queue_t receiveQueue;

@interface Utility : NSObject

//
+ (UIColor *) colorFromColorString:(NSString *)colorString;
+ (UIColor *)colorFromColorString:(NSString *)colorString alpha:(CGFloat)alpha;

#pragma mark- JSON
+ (NSData *)jsonDataWithDictionary:(NSDictionary *)jsonDict;
+ (id)jsonObjectWithJsonData:(NSData *)jsonData;

#pragma mark- md5加密
+ (NSString *)calcStrMD5:(NSString*)str;
+ (unsigned short)calcCRC16:(NSData*)data;
+ (unsigned short)calcStrCRC16:(NSString*)str;

#pragma mark- 16进制字符串与二进制数据转换
+ (NSData *)convertHexString2Data: (NSString *)hexString;
+ (NSString *)convertData2HexString:(NSData *)data;

#pragma mark- 获取wifi名字
//+ (NSString*)ssidForConnectedNetwork;

#pragma mark - 将字典序列化为字符串
/**
 *  将字典序列化为字符串
 *
 */
+ (NSString *)dictionaryToString: (NSDictionary *)dict;


+ (NSString *)arrayToString: (NSArray *)arr;

#pragma mark - 将字符串解析为字典
/**
 *  将字符串解析为字典
 *
 */
+ (NSDictionary *)stringToDictionary: (NSString *)string;

/**
 *  获取json字符串中某一个key对应的值
 *
 */
+ (id)getValueForKey: (NSString *)key inJsonString: (NSString *)jsonStr;
#pragma mark- 手机号类型判断
/**
 *  判断字符串是否为手机
 *  支持 17开头的 4G号码段
 */
+ (BOOL)isKindOfPhone:(NSString *)string;
#pragma mark- 邮箱类型判断
/**
 *  判断字符串是否为邮箱
 *
 */
+ (BOOL)isKindOfEmail:(NSString *)string;


/**
 *  判断字符串是否为验证码
 *
 */
+ (BOOL)isValidatePINcode:(NSString *)PINcode;

#pragma mark - 获取Lua配置路径
/**
 *  获取lua配置路径
 *
 */
+ (NSString *)luaConfigPathForProductId: (NSString *)productId;

#pragma mark- 获取产品配置包主控界面路径

/**
 *  获取产品配置包主控界面路径
 *
 *  @param productId 产品id
 *  @param lang      产品配置包语言
 *
 *  @return 产品配置包主控界面路径
 */
+ (NSString *)productIndexHtmlPathForProductId:(NSString *)productId
                              andLanguage:(NSString *)lang;

/**
 *  获取产品配置包帮助界面路径
 *
 *  @param productId 产品id
 *  @param lang      产品配置包语言
 *
 *  @return 产品配置包帮助界面路径
 */
+ (NSString *)productHelpHtmlPathForProductId:(NSString *)productId
                                   andLanguage:(NSString *)lang;

/**
 *  获取产品配置包关于界面路径
 *
 *  @param productId 产品id
 *  @param lang      产品配置包语言
 *
 *  @return 产品配置包关于界面路径
 */
+ (NSString *)productAboutHtmlPathForProductId:(NSString *)productId
                                   andLanguage:(NSString *)lang;
/**
 *  获取产品配置包更多界面路径
 *
 *  @param productId 产品id
 *  @param lang      产品配置包语言
 *
 *  @return 产品配置包更多界面路径
 */
+ (NSString *)productMoreHtmlPathForProductId:(NSString *)productId
                                   andLanguage:(NSString *)lang;

#pragma mark - 自定义目录
/**
 *  自定义的目录，位于Documents目录下。所有自定义的文件都必须在这个目录下，以避免被iCloud备份，苹果审核会有问题
 *
 */
+ (NSString *)customDirectoryPathInDocuments;

#pragma mark - 产品配置路径
/**
 *  产品配置路径
 *
 */
+ (NSString *)productConfigPath;

+ (NSString *)proGlobalfigPath;
#pragma mark - 用户共用目录
/**
 *  获取用户共用路径
 *
 */
+ (NSString *)usersConfigPath;
#pragma mark - 指定用户路径目录
/**
 *  获取指定用户路径
 *
 */
+ (NSString *)userConfigPathForUserId: (NSString *)userId;
#pragma mark - 用户头像路径
/**
 *  获取指定用户头像路径
 *
 */
+ (NSString *)userAvatarPathForUserId:(NSString *)userId;
#pragma mark - 用户小头像路径
/**
 *  获取指定用户小头像路径
 *
 */
+ (NSString *)userTinyAvatarPathForUserId:(NSString *)userId;
#pragma mark - 用户名下设备图像路径
/**
 *  获取指定产品ID的产品图像路径
 *
 */
+ (NSString *)productImagePathForProductId:(NSString *)productId;
#pragma mark - 产品路径图像
/**
 *  获取产品列表中产品的图像路径
 *
 */
+ (NSString *)productImagePath;

#pragma mark - 保证指定路径目录存在
/**
 *  保证指定路径目录存在，没有则创建
 *
 */
+ (BOOL)ensureDirectoryExistAtPath:(NSString *)dirPath;
#pragma mark - 判断路径是否存在
/**
 *  判断文件是否存在
 *
 */
+ (BOOL)fileExists: (NSString *)fileFullPath;
#pragma mark - 判断用户名类型，分手机用户、邮箱用户、非法用户

+ (NSString *)userTypeString: (NSString *)userName;

#pragma mark- 获取当前系统语言
+ (NSString *)getCurrentLanguage;

#pragma mark - 替换掉字符串中的反斜杠\和单引号'
+ (NSString *)replaceSpecialCharaters: (NSString *)orignal;


/**
 *  计算文件的MD5校验码
 *
 *  @param path 文件路径
 *
 *  @return MD5校验码
 */
+ (NSString *)fileMD5:(NSString*)path;

+ (UIImage *)buttonImageFromColor:(UIColor *)color;

#pragma  mark - 互殴当前的设备唯一识别码 并保存到钥匙串中。
+ (NSString *)GetDeviceToken;
+ (NSString *)getAppVersion;

+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;


+ (BOOL)indexPath:(NSIndexPath*)path isEqualTo:(NSIndexPath*)otherPath;

#pragma mark - nsdate && nsstring
+ (NSString *)dateFormatterToString:(NSString *)formatter;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString*)formatter;
+ (NSDate *)dateFromeString:(NSString*)dateStr withFormatter:(NSString*)formatter;


+ (UIImage *)imageFromView:(UIView *)view;
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (NSInteger)countOfStrLength:(NSString*)str;
/**
 * 将图片转换为PNG/Jpg格式的二进制数   并切换成base64 的数据。
 *
 *  @param image 图片文件。
 *
 *  @return base64的数据
 */
+ (NSString *)getBase64StrWithImage:(UIImage *)image;

/**
 * 将NSString 切换成base64 的数据。
 *
 *  @param NSString text
 *
 *  @return base64的数据
 */
+ (NSString*)getBase64WithString:(NSString*)text;

#pragma mark - APNS Token
+(NSString*)getApnsTokenStrored;
+(void)saveApnsToken:(NSString*)token;

#pragma  mark - MobileAccoutn
+ (NSString*)getRepeatString:(NSString *)repeat;

+ (NSString *)generateThread;

+(UIImage *)getImageFromView:(UIView *)orgView;

+ (BOOL)isSystemVersioniOS8;
+ (BOOL)isSystemVersioniOS9;
+ (BOOL)isAllowedNotification;

+(NSInteger)createSceneId;
@end


