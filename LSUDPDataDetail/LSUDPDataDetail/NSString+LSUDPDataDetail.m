//
//  NSString+LSUDPDataDetail.m
//  LSUDPDataDetail
//
//  Created by 王良山 on 2016/12/9.
//  Copyright © 2016年 liangshanw. All rights reserved.
//

#import "NSString+LSUDPDataDetail.h"

@implementation NSString (LSUDPDataDetail)


+ (NSString *)getDecStrFromHexStr:(NSString *)HexStr
{
    
    NSString * DecStr = [NSString stringWithFormat:@"%lu",strtoul([HexStr UTF8String],0,16)];
    return DecStr;
    
}

+ (NSString *)convertHexStringToDecStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSString *)removeAllEmptyString:(NSString *)string
{
    if (string == nil) return nil;
    NSCharacterSet *emptyspaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *parts = [string componentsSeparatedByCharactersInSet:emptyspaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    NSString *jointStr = @"" ;
    string = [filteredArray componentsJoinedByString:jointStr];
    
    return string;
}

+ (NSString *)removeAllHexheadString:(NSString *)string
{
    
    if (string == nil) return nil;
    string = [string lowercaseString];
    string = [string stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    return string;
}

@end
