//
//  AppDelegate.h
//  Leash
//
//  Created by Reno Reballos on 31/7/13.
//  Copyright (c) 2013 Reno Reballos. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>

static const BOOL LOG_DEBUG_MODE = TRUE;
static const BOOL SAFERANGE_DEBUG_MODE = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readwrite, nonatomic) BOOL isAppBackground;
/*
@property (strong, nonatomic) UIAlertView *warningAlertView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *vilbrateAlertTimer;
 */
@property (nonatomic) int localNotificationCount;

- (void)initialization;
+ (void)consoleLog:(NSString*)msg;

@end
