//
//  CVLog.h
//  CVLogTools
//
//  Created by John on 2016/12/15.
//  Copyright © 2016年 Chivox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CVLog : NSObject

+(void)log:(const char *)file function:(const char *)function line:(NSUInteger)line format:(NSString *)format, ... NS_FORMAT_FUNCTION(4, 5);
@end
