//
//  Notifications.m
//  libcydianotifications
//
//  Created by admin on 3/14/14.
//
//

#import "Notifications.h"

@implementation Notifications

@synthesize notified;

- (id)init
{
    if ( self = [super init] ) {
        self.notified = false;
    }
    return self;
}

- (void)run :(NSTimer *)timer
{
    NSLog(@"Running");
    if(!self.notified)
    {
        [self showAlert];
        self.notified = true;
    }
}

-(void) openApp {
    
    // the SpringboardServices.framework private framework can launch apps,
    //  so we open it dynamically and find SBSLaunchApplicationWithIdentifier()
    void* sbServices = dlopen(SBSERVPATH, RTLD_LAZY);
    int (*SBSLaunchApplicationWithIdentifier)(CFStringRef identifier, Boolean suspended) = dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");
    int result = SBSLaunchApplicationWithIdentifier(CFSTR("com.ioshomebrew.itransmission"), false);
    dlclose(sbServices);
}

-(void) showAlert {
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject: @"Alert!" forKey: (__bridge NSString*)kCFUserNotificationAlertHeaderKey];
    [dict setObject: @"Updates Ready!" forKey: (__bridge NSString*)kCFUserNotificationAlertMessageKey];
    [dict setObject: @"View" forKey:(__bridge NSString*)kCFUserNotificationDefaultButtonTitleKey];
    [dict setObject: @"Cancel" forKey:(__bridge NSString*)kCFUserNotificationAlternateButtonTitleKey];
    
    SInt32 error = 0;
    CFUserNotificationRef alert =
    CFUserNotificationCreate(NULL, 0, kCFUserNotificationPlainAlertLevel, &error, (__bridge CFDictionaryRef)dict);
    
    CFOptionFlags response;
    // we block, waiting for a response, for up to 10 seconds
    if((error) || (CFUserNotificationReceiveResponse(alert, 10, &response))) {
        NSLog(@"alert error or no user response after 10 seconds");
    } else if((response & 0x3) == kCFUserNotificationAlternateResponse) {
        // user clicked on Cancel ... just do nothing
        NSLog(@"cancel");
    } else if((response & 0x3) == kCFUserNotificationDefaultResponse) {
        // user clicked on View ... so, open the UI App
        NSLog(@"view");
        [self openApp];
    }
    CFRelease(alert);
}

@end
