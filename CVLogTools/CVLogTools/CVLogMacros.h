//
//  CVLogMacros.h
//  LogStatTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#ifndef CVLogMacros_h
#define CVLogMacros_h
typedef enum CVLogLevel{
    CVLog_DEBUG = 0,
    CVLog_INFO,
    CVLog_WARN,
    CVLog_ERROR,
    CVLog_FATAL
}CVLogLevel;
#define CVLog(frmt, ...)\
[CVLog log:CVLog_DEBUG file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#define CVLogDebug(frmt, ...)\
[CVLog log:CVLog_DEBUG file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#define CVLogInfo(frmt, ...)\
[CVLog log:CVLog_INFO file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#define CVLogWarn(frmt, ...)\
[CVLog log:CVLog_WARN file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#define CVLogError(frmt, ...)\
[CVLog log:CVLog_ERROR file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#define CVLogFatal(frmt, ...)\
[CVLog log:CVLog_FATAL file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]

#endif /* CVLogMacros_h */
