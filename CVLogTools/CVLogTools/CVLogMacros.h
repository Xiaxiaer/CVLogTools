//
//  CVLogMacros.h
//  LogStatTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#ifndef CVLogMacros_h
#define CVLogMacros_h
#define CVLog(frmt, ...)\
[CVLog log:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__ format:(frmt),## __VA_ARGS__]
#endif /* CVLogMacros_h */
