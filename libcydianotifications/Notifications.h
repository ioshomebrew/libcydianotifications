//
//  Notifications.h
//  libcydianotifications
//
//  Created by admin on 3/14/14.
//
//

#import <Foundation/Foundation.h>
#import "CFUserNotifications.h"
#include <dlfcn.h>
#define SBSERVPATH "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

@interface Notifications : NSObject

@property (nonatomic, assign) BOOL notified;

- (void) run: (NSTimer *)timer;

@end
