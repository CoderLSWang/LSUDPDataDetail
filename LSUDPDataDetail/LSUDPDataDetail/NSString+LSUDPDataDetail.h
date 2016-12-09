//
//  NSString+LSUDPDataDetail.h
//  LSUDPDataDetail
//
//  Created by 王良山 on 2016/12/9.
//  Copyright © 2016年 liangshanw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LSUDPDataDetail)


+ (NSString *)getDecStrFromHexStr:(NSString *)HexStr;

+ (NSString *)convertHexStringToDecStr:(NSString *)str;

+ (NSString *)removeAllEmptyString:(NSString *)string;

+ (NSString *)removeAllHexheadString:(NSString *)string;


@end
