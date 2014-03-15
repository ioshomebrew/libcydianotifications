//
//  main.m
//  libcydianotifications
//
//  Created by admin on 3/14/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#include <Foundation/Foundation.h>
#import "Notifications.h"

int main(int argc, char *argv[]) {
    @autoreleasepool {
        Notifications* daemon = [[Notifications alloc] init];
        
        // start a timer so that the process does not exit.
        NSTimer* timer = [[NSTimer alloc] initWithFireDate: [NSDate date]
                                                  interval: 1.0
                                                    target: daemon
                                                  selector: @selector(run:)
                                                  userInfo: nil
                                                   repeats: NO];
        
        NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer: timer forMode: NSDefaultRunLoopMode];
        [runLoop run];
    }
    return 0;
}