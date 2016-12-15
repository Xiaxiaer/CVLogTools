//
//  HandleLogFile.m
//  LogStatTools
//
//  Created by John on 2016/12/2.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import "HandleLogFile.h"

@implementation HandleLogFile

-(NSString *)createLogFileWithPath:(NSString *)logFilePath
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    //20161202
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *logTime = [formatter stringFromDate:[NSDate date]];
    NSString *logCurrentPath = [[logFilePath stringByAppendingPathComponent:logTime] stringByAppendingString:@".log"];
    //如果日志文件存在，那就说明文件名字一毛一样直接写~
    if ([[NSFileManager defaultManager]fileExistsAtPath:logCurrentPath]) {
        
    }
    //如果不存在创建文件,检查有无其他log文件，检查是否7天之内
    else
    {
        //遍历文件夹下文件
        NSDirectoryEnumerator *enumerator =[[NSFileManager defaultManager] enumeratorAtPath:logFilePath];
        for ( NSString *file in enumerator) {
            //如果有log文件
            if ([file hasSuffix:@".log"]) {
                //取名字去判断时间
                int fileCreateTime=[[[file lastPathComponent]stringByDeletingPathExtension] intValue];
                int currentTime = [logTime intValue];
                //比对时间差 大于7天
                if ((currentTime - fileCreateTime) >= 7) {
                    //删除~
                   [[NSFileManager defaultManager]removeItemAtPath:[logFilePath stringByAppendingPathComponent:file] error:nil];
                }
                //小于7天上传然后删掉
                else{
                    //上传、删除
                }
                
            }
        }
        //创建文件
        bool isCreateOK = [[NSFileManager defaultManager]createFileAtPath:logCurrentPath contents:nil attributes:nil];
    }
    self.currentLogPath = logCurrentPath;
    return logCurrentPath;
}
-(void)writeLogIntoFile:(NSString *)logFilePath
{
     
}

@end
