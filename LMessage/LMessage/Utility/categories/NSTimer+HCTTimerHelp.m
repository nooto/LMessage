//
//  NSTimer+HCTTimerHelp.m
//  HomeCtrl
//
//  Created by jiangjun on 1/19/15.
//  Copyright (c) 2015 1719. All rights reserved.
//

#import "NSTimer+HCTTimerHelp.h"

@implementation NSTimer (HCTTimerHelp)
+ (NSTimer *)nrc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(eoc_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)eoc_blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}


@end
