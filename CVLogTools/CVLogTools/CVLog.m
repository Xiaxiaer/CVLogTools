//
//  CVLog.m
//  CVLogTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import "CVLog.h"

@implementation CVLog

+(void)log:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"%@",message);
    va_end(args);
}
@end
