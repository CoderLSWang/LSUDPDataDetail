//
//  LSUDPDataDetail.h
//  LSUDPDataDetail
//
//  Created by 王良山 on 2016/12/9.
//  Copyright © 2016年 liangshanw. All rights reserved.
//
//Tip:This component is developmented based on GCDAsyncUdpSocket library,Use pod to import CocoaAsyncSocket file will be imported together, if the file repeat ,please delete it
//UDP instruction contains the communication address, device Id, send data, etc.Specific please refer to my blog about instruction interpretations: （I donot know whice developer platform I should choose. If you know, please recommend a developer platform in the United States）

//注意：此组件是基于CocoaAsyncSocket框架开发，使用pod导入时，CocoaAsyncSocket文件也会被一起导入进来，如有重复请删除
//UDP指令里面包含通信的地址，设备Id，发送的数据等。具体指令协议解读请参阅我的博客：http://www.jianshu.com/users/5df251480905/latest_articles


  //https://github.com/CoderLSWang/LSUDPDataDetail
#import <Foundation/Foundation.h>

//udp
#import "GCDAsyncUdpSocket.h"
#import "GCDAsyncSocket.h"
#import "NSData+LSUDPDataDetail.h"
#import "NSString+LSUDPDataDetail.h"

@interface LSUDPDataDetail : NSObject


+ (id)sharedInstance;

#pragma mark --------------------
#pragma mark Initialization method
///Binding and initialize the UDP port, get UdpSocket object / 绑定和初始化UDP端口，获取UdpSocket对象
- (GCDAsyncUdpSocket *)bindToPortWithsocketHost:(NSString *)socketHost andservicePort:(uint16_t)servicePort andUdpSocketDelegate:(id<GCDAsyncUdpSocketDelegate>)delegate;


///convert the data to hexadecimal string / 将data转换为十六进制字符串
+(NSString *)convertDataToHexDataStr:(NSData *)data;

///convert the data to decimal string / 将data转换为十进制字符串
+(NSString *)convertDataToDecDataStr:(NSData *)data;

///convert hexadecimal string to decimal strings / 将16进制字符串转10进制字符串
+ (NSString *)convertHexStrToDecStr:(NSString *)HexStr;


#pragma mark Convert hexadecimal string to data of byte array
///Convert hexadecimal string to data of byte array/ 将16进制字符串转换为byte数组的data
+ (NSData *)commandByteDataFromHexString:(NSString *)hexString;

#pragma mark ------------
#pragma mark 设备ID、设备地址 可以从下面四个方法中获取
///cut out decimal string from data / 从data中截取出十进制的字符串
+(NSString *)getDecStringFromData:(NSData *)data withRange:(NSRange)range;

///cut out hexadecimal string from data / 从data中截取出十六进制的字符串
+(NSString *)getHexStringFromData:(NSData *)data withRange:(NSRange)range;

///cut out decimal string from hexadecimal string / 从HexString中截取出十进制的字符串
+(NSString *)getDecStringFromHexString:(NSString *)hexString withRange:(NSRange)range;

///cut out hexadecimal string from itself / 从HexString中截取出十六进制的字符串
+(NSString *)getHexStringFromHexString:(NSString *)hexString withRange:(NSRange)range;



@end