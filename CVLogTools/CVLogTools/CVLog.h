//
//  CVLog.h
//  CVLogTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVLogMacros.h"
@interface CVLog : NSObject<NSURLSessionDelegate>
@property (nonatomic,assign) CVLogLevel reportLogLevel;
@property (nonatomic,copy) NSString *reportServer;
@property (nonatomic,copy) NSString *logSavePath;
@property (nonatomic,assign) int logSaveMaxDate;
@property (nonatomic,copy) NSString *currentLogFilePath;
+(instancetype)getInstance;

+(void)log:(CVLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6);
-(void)log:(CVLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line message:(NSString *)message;
@end
