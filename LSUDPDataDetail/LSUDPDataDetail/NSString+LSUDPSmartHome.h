//
//  NSString+LSUDPSmartHome.h
//  LSUDPSmarHome
//
//  Created by 王良山 on 2016/11/30.
//  Copyright © 2016年 liangshanw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSUDPSmartHome)

+ (NSString *)getDecStrFromHexStr:(NSString *)HexStr;

+ (NSString *)convertHexStringToDecStr:(NSString *)str;

+ (NSString *)removeAllEmptyString:(NSString *)string;

+ (NSString *)removeAllHexheadString:(NSString *)string;

@end
