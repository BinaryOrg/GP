//
//  AppDelegate+BackgroundTask.m
//

#import "TEMPAppDelegate+BackgroundTask.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import "TEMPMacro.h"

@implementation TEMPAppDelegate (BackgroundTask)

- (void)setCount:(NSInteger)count {
    objc_setAssociatedObject(self, @selector(count), @(count), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)count {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBackgroundTaskIdenifier:(UIBackgroundTaskIdentifier)backgroundTaskIdenifier {
    objc_setAssociatedObject(self, @selector(backgroundTaskIdenifier), @(backgroundTaskIdenifier), OBJC_ASSOCIATION_ASSIGN);
}

- (UIBackgroundTaskIdentifier)backgroundTaskIdenifier {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.count ++;
        }];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self beginTask];
}

- (void)beginTask {
    self.backgroundTaskIdenifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endTask];
    }];
}

- (void)endTask {
    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdenifier];
    self.backgroundTaskIdenifier = UIBackgroundTaskInvalid;
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self endTask];
}
@end
