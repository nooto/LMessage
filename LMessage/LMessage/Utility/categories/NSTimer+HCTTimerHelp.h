//
//  NSTimer+HCTTimerHelp.h
//  HomeCtrl
//
//  Created by jiangjun on 1/19/15.
//  Copyright (c) 2015 1719. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HCTTimerHelp)
+ (NSTimer *)nrc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats;
@end
