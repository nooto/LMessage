//
//  Utility.m
//  HomeCtrl
//
//

#import "Utility.h"
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Macro.h"

#define CHUNK_SIZE 1024*8
@implementation Utility

#pragma mark- JSON
/**
 将dictionary转换为json数据
 */
+ (NSData *)jsonDataWithDictionary:(NSDictionary *)jsonDict {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:jsonDict
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    
    if ([jsonData length] >0 && error == nil) {
        //        DLog(@"jsonData:%@",jsonData);
        return jsonData;
    }
    else if ([jsonData length] == 0 && error == nil) {
    }
    else if (error != nil) {
    }
    return nil;
}

+ (id)jsonObjectWithJsonData:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                   JSONObjectWithData:jsonData
                   options:NSJSONReadingAllowFragments
                   error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }
    return nil;
}

+ (NSString *)dictionaryToString: (NSDictionary *)dict{
    if (nil == dict) return nil;
    
    NSError *error;
    NSData *strData = [NSJSONSerialization dataWithJSONObject: dict options: 0 error: &error];
    
    if (strData != nil && error == nil) {
        
        return [[NSString alloc] initWithData: strData encoding: NSUTF8StringEncoding];
    }
    
    return nil;
    
    
}

+ (NSString *)arrayToString: (NSArray *)arr{
    if (nil == arr) return nil;
    
    NSError *error;
    NSData *strData = [NSJSONSerialization dataWithJSONObject: arr options: 0 error: &error];
    
    if (strData != nil && error == nil) {
        
        return [[NSString alloc] initWithData: strData encoding: NSUTF8StringEncoding];
    }
    
    return nil;
}

+ (NSDictionary *)stringToDictionary: (NSString *)string{
    
    if(string == nil){
        return nil;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSData *jsonData = [string dataUsingEncoding: NSUTF8StringEncoding];
    
    NSError *error = nil;
    id jsonDict = [NSJSONSerialization
                   JSONObjectWithData:jsonData
                   options:NSJSONReadingAllowFragments
                   error:&error];
    
    if (jsonDict != nil && error == nil) {
        
        if ([jsonDict isKindOfClass: [NSDictionary class]]) {
            return jsonDict;
        }
    }
    return nil;
}


#pragma mark- MD5
/**
 将str进行MD5加密
 */
+ (NSString *)calcStrMD5:(NSString*)str {
    if (!str) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (unsigned short) calcCRC16:(NSData*)data
{
    
    const char *dataPtr = (const char *)data.bytes;
    
    unsigned short crc = 0xFFFF;          // initial value
    unsigned short polynomial = 0x1021;   // 0001 0000 0010 0001  (0, 5, 12)
    
    for (int j = 0; j < data.length; ++j) {
        for (int i = 0; i < 8; i++) {
            char bit = ((dataPtr[j]   >> (7-i) & 1) == 1);
            char c15 = ((crc >> 15    & 1) == 1);
            crc <<= 1;
            if (c15 ^ bit) crc ^= polynomial;
        }
    }
    
    crc &= 0xffff;
    
    return crc&0xFFFF;
}

+ (unsigned short) calcStrCRC16:(NSString*)str
{
    return [self calcCRC16:[str dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark- 16进制字符串与二进制数据转换
+ (NSData *)convertHexString2Data: (NSString *)hexString{
    
    // NSString --> hex
    if (hexString == nil) {
        return  nil;
    }
    
    if (hexString.length % 2 == 1) {
        hexString = [NSString stringWithFormat: @"0%@", hexString];
    }
    
    const char *buf = [hexString UTF8String];
    NSMutableData *data;
    if (buf)
    {
        size_t len = strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        for(uint32_t i = 0 ; i < len; i+=2)
        {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1])) )
            {
                if (!data) {
                    data = [NSMutableData data];
                }
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [data appendBytes:(void *)(&tmp)length:1];
            }
            else
            {
                break;
            }
        }
    }
    
    return data;
}

+ (NSString *)convertData2HexString:(NSData *)data{
    unsigned char const *p;
    p = [data bytes];
    NSString *hexStr = @"";
    for (NSInteger i = 0; i < data.length; i++) {
        unsigned char temp = p[i];
        NSString *newHexStr = [NSString stringWithFormat:@"%02x", temp];
        hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
    }
    return hexStr;
}

#pragma mark- 获取wifi
//+ (NSString*)ssidForConnectedNetwork{
//    NSArray *interfaces = (__bridge_transfer NSArray*)CNCopySupportedInterfaces();
//    NSDictionary *info = nil;
//    for (NSString *ifname in interfaces) {
//        info = (__bridge_transfer NSDictionary*)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
//        if (info && [info count]) {
//            break;
//        }
//        info = nil;
//    }
//    
//    NSString *ssid = nil;
//    
//    if ( info ){
//        ssid = [info objectForKey:@"SSID"];
//    }
//    info = nil;
//    
//    if ([ssid isKindOfClass: [NSNull class]]) {
//        return nil;
//    }
//    return ssid? ssid:nil;
//}

+ (id)getValueForKey: (NSString *)key inJsonString: (NSString *)jsonStr
{
    NSDictionary *dict = [Utility stringToDictionary: jsonStr];
    return dict[key];
}

+ (BOOL)indexPath:(NSIndexPath*)path isEqualTo:(NSIndexPath*)otherPath{
    if (!path && !otherPath) {
        return YES;
    }
    
    if (!path || !otherPath) {
        return NO;
    }
    
    if (path.section == otherPath.section && path.row == otherPath.row) {
        return YES;
    }
    
    return NO;
}


#pragma mark- 手机号邮箱类型判断
+ (BOOL)isKindOfPhone:(NSString *)string
{
    BOOL isPhone = NO;
    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";    //
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if ([phonePredicate evaluateWithObject:string]) {
        isPhone = YES;
    }
    return isPhone;
}
+ (BOOL)isKindOfEmail:(NSString *)string
{
    BOOL isEmail = NO;
    NSString *emailRegex = @"^([a-zA-Z0-9_])+@([a-zA-Z0-9])+((\\.[a-zA-Z]{2,6}){1,2})$";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    if ([emailPredicate evaluateWithObject:string]) {
        isEmail = YES;
    }
    return isEmail;
}
+ (BOOL)isValidatePINcode:(NSString *)PINcode
{
    if (!PINcode) return NO;
    if (PINcode.length <= 0) return NO;
    
    BOOL isPINcode = NO;
    NSString *pinRegex =@"^[0-9]*$";
    NSPredicate *PINcodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
    if ([PINcodeTest evaluateWithObject:PINcode]) {
        isPINcode = YES;
    }
    return isPINcode;

    
//    NSString *pinRegex =@"^[0-9]*$";
//    NSPredicate *PINcodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
//    return  [PINcodeTest evaluateWithObject:PINcode];
}


+ (UIColor *) colorFromColorString:(NSString *)colorString{
    return [Utility colorFromColorString:colorString alpha:1.0f];
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



#pragma mark - 获取配置路径
+ (NSString *)luaConfigPathForProductId: (NSString *)productId
{
    return [NSString stringWithFormat: @"%@/%@/control/config.json", [Utility productConfigPath], productId];
}

+ (NSString *)usersConfigPath {
    return [[Utility customDirectoryPathInDocuments] stringByAppendingString:@"/AllUsers"];
}

+ (NSString *)userConfigPathForUserId: (NSString *)userId {
    return [[Utility usersConfigPath] stringByAppendingString:[NSString stringWithFormat:@"/%@",userId]];
}

+ (NSString *)userAvatarPathForUserId:(NSString *)userId {
    return [[Utility userConfigPathForUserId:userId] stringByAppendingString:[NSString stringWithFormat:@"/%@.png",userId]];
}

+ (NSString *)userTinyAvatarPathForUserId:(NSString *)userId {
    return [[Utility userConfigPathForUserId:userId] stringByAppendingString:[NSString stringWithFormat:@"/%@_tiny.png",userId]];
}

+ (NSString *)productImagePath {
    return [[Utility productConfigPath] stringByAppendingString:[NSString stringWithFormat:@"/productImage"]];

}

+ (NSString *)productImagePathForProductId:(NSString *)productId {
    return [[Utility productImagePath] stringByAppendingString:[NSString stringWithFormat:@"/%@.png",productId]];
}

+ (NSString *)customDirectoryPathInDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}


+ (BOOL)fileExists: (NSString *)fileFullPath
{
    return [[NSFileManager defaultManager] fileExistsAtPath: fileFullPath];
}


+ (NSString *)productConfigPath
{
    return [[Utility customDirectoryPathInDocuments] stringByAppendingString: @"/plugin"];
}

+ (NSString *)proGlobalfigPath{
    NSString *globalPath = [Utility productConfigPath];
    return [globalPath stringByAppendingPathComponent:@"global"];
}

+ (NSString *)productDirectoryPath: (NSString *)productId andLanguage: (NSString *)lang{
    return [[Utility productConfigPath] stringByAppendingFormat: @"/%@/view_%@", productId, lang];
}

+ (NSString *)productIndexHtmlPathForProductId: (NSString *)productId
                                   andLanguage: (NSString *)lang{
    return [[Utility productDirectoryPath: productId
                                      andLanguage: lang]
                stringByAppendingFormat: @"/index.html"];
}

+ (NSString *)productHelpHtmlPathForProductId:(NSString *)productId
                                  andLanguage:(NSString *)lang{
    return [[Utility productDirectoryPath: productId
                                      andLanguage: lang]
            stringByAppendingFormat: @"/help.html"];
}

+ (NSString *)productAboutHtmlPathForProductId:(NSString *)productId
                                   andLanguage:(NSString *)lang{
    return [[Utility productDirectoryPath: productId
                                      andLanguage: lang]
            stringByAppendingFormat: @"/about.html"];
}

+ (NSString *)productMoreHtmlPathForProductId:(NSString *)productId
                                  andLanguage:(NSString *)lang{
    return [[Utility productDirectoryPath: productId
                                      andLanguage: lang]
            stringByAppendingFormat: @"/more.html"];
}

#pragma mark - 确保配置路径存在
+ (BOOL)ensureDirectoryExistAtPath:(NSString *)dirPath {
    BOOL isDir ;
    if ([[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir] && isDir) {
        return YES;
    }else {
        NSError *error = nil;
        BOOL isDirExist = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        return isDirExist;
    }
}

+ (NSString *)userTypeString: (NSString *)userName
{
    if ([Utility isKindOfEmail: userName]) {
        return @"email";
    }
    
    if ([Utility isKindOfPhone: userName]) {
        return @"phone";
    }
    
    return nil;
}

+ (NSString*)getRepeatString:(NSString *)repeat{
    NSMutableString *string = [NSMutableString string];
    NSString*repeatStr =  repeat;
    repeatStr = [repeatStr stringByReplacingOccurrencesOfString:@"，" withString:@","];
    if ([repeatStr isEqualToString:@"1,2,3,4,5"]) {
        return @"工作日";
    }
    else if ([repeatStr isEqualToString:@"6,7"]){
        return @"休息日";
    }
    else if ([repeatStr isEqualToString:@"1,2,3,4,5,6,7"]){
        return @"每天";
    }
    
    NSArray *arr = [repeatStr componentsSeparatedByString:@","];
    for (NSInteger i = 0; i < arr.count; i++) {
        NSString *subStr = [arr objectAtIndex:i];
        
        
//        if (i == 0) {
//            [string appendString:@"("];
//        }
        if ([subStr isEqualToString:@"0"]) {
            string = nil;
            break;
        }
        
        if ([subStr isEqualToString:@"1"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周一"];
        }
        else if ([subStr isEqualToString:@"2"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周二"];
        }
        else if ([subStr isEqualToString:@"3"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周三"];
        }
        else if ([subStr isEqualToString:@"4"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周四"];
        }
        else if ([subStr isEqualToString:@"5"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周五"];
        }
        else if ([subStr isEqualToString:@"6"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周六"];
        }
        else if ([subStr isEqualToString:@"7"]){
            if (i > 0) [string appendString:@","];
            [string appendString:@"周日"];
        }
    }
    return string;
}

#pragma mark- 获取当前系统语言
+ (NSString *)getCurrentLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    //语言映射
    if ([currentLanguage isEqualToString:@"zh-Hans"])
        currentLanguage = @"zh-cn";
    else if ([currentLanguage isEqualToString:@"zh-Hant"])
        currentLanguage = @"zh-hk";
    else if ([currentLanguage isEqualToString:@"en"])
        currentLanguage = @"en-us";
    else if ([currentLanguage isEqualToString:@"ru"])
        currentLanguage = @"ru-ru";
    else if ([currentLanguage isEqualToString:@"ja"])
        currentLanguage = @"ja-jp";
    else if ([currentLanguage isEqualToString:@"es"])
        currentLanguage = @"es-es";
    else if ([currentLanguage isEqualToString:@"ko"])
        currentLanguage = @"ko-kr";
    else
        currentLanguage = @"zh-cn";
    return currentLanguage;
}

+ (NSString *)replaceSpecialCharaters: (NSString *)orignal{
    
    if (!orignal) {
        return nil;
    }
    
    orignal = [orignal stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    orignal = [orignal stringByReplacingOccurrencesOfString:@"'" withString: @"\\'"];
    
    return orignal;
}

+ (NSString*)fileMD5:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) return nil;
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        @autoreleasepool {
            NSData* fileData = [handle readDataOfLength: CHUNK_SIZE ];
            CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
            if( [fileData length] == 0 ) done = YES;
        }
        
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}

+ (UIImage *)buttonImageFromColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


#define KUUID_Key   @"uuidkey_com.wondershare.EHouse"
#define KUUID_Value @"uuid_com.wondershare.EHouse"
+ (NSString *)GetDeviceToken{
    
    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:KUUID_Value andServiceName:KUUID_Key error:nil];
    if ( !uuid || uuid.length <= 0 ) {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidstring = CFUUIDCreateString(nil, puuid);
        
        uuid =(__bridge NSString*) CFStringCreateCopy(NULL, uuidstring);
        CFRelease(puuid);
        CFRelease(uuidstring);
        
        [SFHFKeychainUtils storeUsername:KUUID_Value andPassword:uuid forServiceName:KUUID_Key updateExisting:YES error:nil];
    }
    return uuid;
}

+(NSString*)getAppVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
}

+ (BOOL)isSystemVersioniOS8 {
    //check systemVerson of device
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 8.0f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isSystemVersioniOS9 {
    //check systemVerson of device
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 9.0f) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isAllowedNotification {
     //iOS8 check if user allow notification
    if ([self isSystemVersioniOS8]) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    }
    else {//iOS7
        UIUserNotificationSettings *type =[[UIApplication sharedApplication] currentUserNotificationSettings];
        if(UIUserNotificationTypeNone != type.types)
            return YES;
    }
    
    return NO;
}


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSDate *)dateFromeString:(NSString*)dateStr withFormatter:(NSString*)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}


+ (NSString *)dateFormatterToString:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];

    return currentDateStr;
}

+ (NSString*)getBase64WithString:(NSString*)text{
    NSData *data=[text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    return base64Str;
}


+ (NSString *)getBase64StrWithImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 1);//将图片转换为PNG格式的二进制数
    if (nil == data) {
        data = UIImagePNGRepresentation(image);//将图片转换为JPG格式的二进制数据
    }
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    return base64Str;
}

+ (NSInteger)countOfStrLength:(NSString*)str {
    NSInteger strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

#pragma mark - apns token
+(NSString*)getApnsTokenStrored{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    // 存储deviceToken到本地
    NSString *deviceTokenStrored = [userDefaults objectForKey: kUserDefaultsDeviceToken];
    return deviceTokenStrored;
}

+ (void)saveApnsToken:(NSString *)token{
    if (token) {
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:token forKey:kUserDefaultsDeviceToken];
        [userDefaults synchronize];
    }
}
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

#pragma  mark - MobileAccoutn
+ (NSString *)generateThread{

// 取时间戳作为thread，time是13位，超过13位硬件处理不了，报错。(为什么不用timeIntervalSinceReferenceDate)
//    NSTimeInterval time = ([[NSDate date] timeIntervalSince1970] - 1410000000) * 1000000 + arc4random() % 100;
//    return [NSString stringWithFormat:@"L%lld",(long long)time];
    
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    return [NSString stringWithFormat:@"L%lld",(long long)time];
}

+ (UIImage *)getImageFromView:(UIView *)orgView{
    if (!orgView) {
        return nil;
    }
    
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(long)getCurrentTimeInterval{
    //    NSTimeZone *zone = [NSTimeZone defaultTimeZone];
    //
    //    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    //    NSDate *localDate = [[NSDate date] dateByAddingTimeInterval:interval];
    long timeInterval = [[NSDate date] timeIntervalSince1970];
    return timeInterval;
}

+(NSInteger)createSceneId{
    return [[NSDate date] timeIntervalSince1970];
}

@end
