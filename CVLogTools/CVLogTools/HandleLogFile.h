//
//  HandleLogFile.h
//  LogStatTools
//
//  Created by John on 2016/12/2.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _LogLevel{
    Log_DEBUG = 0,
    Log_INFO,
    Log_WARN,
    Log_ERROR,
    Log_FATAL
}LogLevel;
@interface HandleLogFile : NSObject

/**
 日志文件当前路径
 */
@property (nonatomic,copy) NSString *currentLogPath;

/**
 创建日志文件在给定的目录下

 @param logFilePath 传入的是一个目录
 @return 当前日志文件路径
 */
-(NSString *)createLogFileWithPath:(NSString *)logFilePath;

/**
 写日志进日志文件

 @param logFilePath 日志文件路径
 */
-(void)writeLogIntoFile:(NSString *)logFilePath;

+ (void)log:(BOOL)asynchronous
      level:(NSString*)level
       flag:(BOOL)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ... NS_FORMAT_FUNCTION(9,10);
+(void)log:(const char *)file function:(const char *)function line:(NSUInteger)line;
+(void)log:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4, 5);
@end
