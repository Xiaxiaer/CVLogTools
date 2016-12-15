//
//  CVLog.m
//  CVLogTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import "CVLog.h"

@implementation CVLog

+(void)log:(CVLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6)
{
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"\nlevel:%d\nfile:%s,\nfunc:%s,\nline:%d,\nmessage:%@",level,file,function,line,message);
    va_end(args);
}
@end
