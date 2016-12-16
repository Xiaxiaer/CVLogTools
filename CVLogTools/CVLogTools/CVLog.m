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
        constants.logSavePath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Logs"];
        constants.reportServer = @"";
        constants.logSaveMaxDate = 7;
        
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
    //如果设置的存放路径不存在则去创建此路径
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.logSavePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:self.logSavePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //本次日志时间
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    //20161216
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *logTime = [formatter stringFromDate:[NSDate date]];
    
    //遍历文件夹下文件 小于logSaveMaxDate的可以将路径放在一个数组里去请求~
    NSDirectoryEnumerator *enumerator =[[NSFileManager defaultManager] enumeratorAtPath:self.logSavePath];
    for ( NSString *file in enumerator) {
        //如果有log文件
        if ([file hasSuffix:@".log"]) {
            //取名字去判断时间
            int fileCreateTime=[[[file lastPathComponent]stringByDeletingPathExtension] intValue];
            int currentTime = [logTime intValue];
            //比对时间差 大于7天
            if ((currentTime - fileCreateTime) > self.logSaveMaxDate) {
                //删除~
                [[NSFileManager defaultManager]removeItemAtPath:[self.logSavePath stringByAppendingPathComponent:file] error:nil];
            }
            else if (currentTime == fileCreateTime)
            {
                //如果是同一天继续使用这个来写入日志
                self.currentLogFilePath = [self.logSavePath stringByAppendingPathComponent:file];
            }
            //小于7天上传然后删掉
            else if((currentTime - fileCreateTime) < self.logSaveMaxDate){
                //上传、删除
                [self upLoadWith:[self.logSavePath stringByAppendingPathComponent:file]];
            }
            
        }
    }
    //处理完上面的（有log就上传 大于logSaveMaxDate的直接删 小于的都上传） 创建本次的日志文件
    if (self.currentLogFilePath == nil) {
        NSString *logCurrentPath = [[self.logSavePath stringByAppendingPathComponent:logTime] stringByAppendingString:@".log"];
        //如果日志文件不存在
        if (![[NSFileManager defaultManager]fileExistsAtPath:logCurrentPath]) {
            [[NSFileManager defaultManager] createFileAtPath:logCurrentPath contents:nil attributes:nil];
            self.currentLogFilePath = logCurrentPath;
        }
        //如果存在这说明是有上传
        else
        {
            
        }

    }
    else
    {
        
    }
    //格式化日志信息
    NSDictionary *dic = @{@"LogLevel":@(level),@"File":[NSString stringWithUTF8String:file],@"Func":[NSString stringWithUTF8String:function],@"Line":@(line),@"ErrorMsg":message};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *content = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //写入文件 判断是否是在设置的report level之上
    if (level>=self.reportLogLevel) {
        [self writeLogtoFile:content file:self.currentLogFilePath];

    }

}
-(void)upLoadWith:(NSString *)reportLogFilePath
{
//    NSString *urlStr = [NSString stringWithFormat: @"http://182.61.14.242/sdk-log/%@/%@/%@",_appkey,_formattedDate,filename];
   NSString *urlStr = [self.reportServer stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    //POST
    //            [request setValue:[NSString stringWithFormat:@"form-data;name=\"file\";filename=\"%@\"",filename] forHTTPHeaderField:@"Content-Disposition"];
    //    [request addValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =  [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURL *fileUrl =   [NSURL fileURLWithPath:reportLogFilePath];
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[NSData dataWithContentsOfURL:fileUrl]];
    [request setHTTPBody:postBody];
    
    NSURLSessionUploadTask *uploadtask =   [session uploadTaskWithRequest:request fromFile:fileUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            //上传成功 删除
            if ([[NSFileManager defaultManager] removeItemAtPath:reportLogFilePath error:nil]) {
                NSLog(@"删除成功");
            }
            else
            {
                NSLog(@"没有");
            }
        }
        
        else
        {
            NSLog(@"%@",error.localizedFailureReason);
        }
    }];
    [[session uploadTaskWithRequest:request fromFile:fileUrl] resume];
    [uploadtask resume];

}
-(void)writeLogtoFile:(NSString *)content file:(NSString *)filepath
{
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:filepath];
    [outFile seekToEndOfFile];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [outFile writeData:data];
    NSData *linedata = [@",\n" dataUsingEncoding:NSUTF8StringEncoding];
    [outFile writeData:linedata];

    [outFile closeFile];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
//    CGFloat value = (CGFloat)totalBytesSent / totalBytesExpectedToSend;
//    // [NSThread sleepForTimeInterval:0.2];
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        //        self.progressView.progress = value;
//    }];
//    
//    NSLog(@"上传进度；value = %.03lf",value);
}

-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
//    NSLog(@"上传失败");
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    
}
@end
