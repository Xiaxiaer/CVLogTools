//
//  CVLog.m
//  CVLogTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import "CVLog.h"
@implementation CVLog
+(instancetype)getInstance
{
    static CVLog *constants = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        constants = [[self alloc] init];
        constants.reportLogLevel = CVLog_ERROR;
        constants.logSavePath=@"";
    });
    return constants;

}

+(void)log:(CVLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6)
{
    va_list args;
    va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    [self.getInstance log:level file:file function:function line:line message:message];
    va_end(args);
}
-(void)log:(CVLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line message:(NSString *)message
{
    //如果是大于或者等于设置的级别 message写入上传
    if (level>=self.reportLogLevel) {
        
    }
    else{
        return;
    }
    NSLog(@"\nlevel:%d\nfile:%s,\nfunc:%s,\nline:%d,\nmessage:%@\nreportLogLevel:%d",level,file,function,line,message,self.reportLogLevel);

}

@end
