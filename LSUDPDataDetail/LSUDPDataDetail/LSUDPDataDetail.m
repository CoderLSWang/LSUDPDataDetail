//
//  LSUDPDataDetail.m
//  LSUDPDataDetail
//
//  Created by 王良山 on 2016/12/9.
//  Copyright © 2016年 liangshanw. All rights reserved.
//

#import "LSUDPDataDetail.h"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block)               \
static dispatch_once_t pred = 0;                                \
__strong static id _sharedObject = nil;                         \
dispatch_once(&pred, ^{                                         \
_sharedObject = block();                                        \
});                                                             \
return _sharedObject;

@interface LSUDPDataDetail ()

@end

@implementation LSUDPDataDetail


+ (id)sharedInstance {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

#pragma mark --------------------
#pragma mark Convert hexadecimal string to data of byte array
///Convert hexadecimal string to data of byte array/ 将16进制字符串转换为byte数组的data
+ (NSData *)commandByteDataFromHexString:(NSString *)hexString
{
    if (hexString == nil) {
        NSLog(@"Introduced hexadecimal string is empty");
        return nil;
    }
    hexString = [NSString removeAllEmptyString:hexString];
    hexString = [NSString removeAllHexheadString:hexString];
    
    if (hexString.length % 2 == 1) NSLog(@"Convert hexadecimal string to data of byte array is failed, please check out the hexadecimal string");
    
    Byte commandByte[hexString.length / 2];
    for (int i = 0; i < hexString.length;  i = i + 2) {
        NSString *subHexStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSString *subDecStr = [self convertHexStrToDecStr:subHexStr];
        commandByte[i / 2] = subDecStr.integerValue;
    }
    NSMutableData *commandData = [[NSMutableData alloc] initWithBytes:commandByte length:(hexString.length / 2)];
    return commandData;
}


#pragma mark --------------------
#pragma mark data和string的处理
///convert the data to hexadecimal string / 将data转换为十六进制字符串
+(NSString *)convertDataToHexDataStr:(NSData *)data
{
    return [NSData convertDataToHexStr:data];
}

///convert the data to decimal string / 将data转换为十进制字符串
+(NSString *)convertDataToDecDataStr:(NSData *)data
{
    NSString *dataHexStr = [NSData convertDataToHexStr:data];
    return [NSString getDecStrFromHexStr:dataHexStr];
}

///cut out decimal string from data / 从data中截取出十进制的字符串
+(NSString *)getDecStringFromData:(NSData *)data withRange:(NSRange)range
{
    NSString *dataHexStr = [self convertDataToHexDataStr:data];
    NSString *deviveIdHexStr = [dataHexStr substringWithRange:range];
    NSString *deviceIdDecStr = [NSString getDecStrFromHexStr:deviveIdHexStr];
    return deviceIdDecStr;
}

///cut out hexadecimal string from data / 从data中截取出十六进制的字符串
+(NSString *)getHexStringFromData:(NSData *)data withRange:(NSRange)range
{
    NSString *dataHexStr = [self convertDataToHexDataStr:data];
    NSString *deviveIdHexStr = [dataHexStr substringWithRange:range];
    return deviveIdHexStr;
}

///cut out decimal string from hexadecimal string / 从HexString中截取出十进制的字符串
+(NSString *)getDecStringFromHexString:(NSString *)hexString withRange:(NSRange)range
{
    NSString *deviveIdHexStr = [hexString substringWithRange:range];
    NSString *deviceIdDecStr = [NSString getDecStrFromHexStr:deviveIdHexStr];
    return deviceIdDecStr;
}

///cut out hexadecimal string from itself / 从HexString中截取出十六进制的字符串
+(NSString *)getHexStringFromHexString:(NSString *)hexString withRange:(NSRange)range
{
    return [hexString substringWithRange:range];
}

///convert hexadecimal string to decimal strings / 将16进制字符串转10进制字符串
+ (NSString *)convertHexStrToDecStr:(NSString *)HexStr
{
    return [NSString getDecStrFromHexStr:HexStr];
}


@end
