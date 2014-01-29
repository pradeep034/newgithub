//
//  AppDelegate.m
//  Leash
//
//  Created by Reno Reballos on 31/7/13.
//  Copyright (c) 2013 Reno Reballos. All rights reserved.
//

#import "AppDelegate.h"
#import "PhilipsKeyfob.h"

@implementation AppDelegate
@synthesize isAppBackground;
/*
@synthesize warningAlertView;
@synthesize audioPlayer;
@synthesize vilbrateAlertTimer;
 */
@synthesize localNotificationCount;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    isAppBackground = NO;
    NSLog(@"UIScreen: %@", [[UIScreen mainScreen] debugDescription]);
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];

    [self initialization];
    return YES;
}

- (void)initialization
{
    NSLog(@"initialization called");
    
    [[PhilipsKeyfob sharedInstance] generateDefaultData];
    [[PhilipsKeyfob sharedInstance] initConnection];
    [[PhilipsKeyfob sharedInstance] assignRootViewController:self.window];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
    isAppBackground = YES;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
    isAppBackground = YES;
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
	isAppBackground = NO;
	localNotificationCount = 0;
	application.applicationIconBadgeNumber = localNotificationCount;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
    isAppBackground = NO;
	if([PhilipsKeyfob sharedInstance].CM.state == CBCentralManagerStatePoweredOff)
	{
		NSLog(@"Switched of ble");
		[[PhilipsKeyfob sharedInstance] centralManagerStateChange:[PhilipsKeyfob sharedInstance].CM.state];
		//[PhilipsKeyfob sharedInstance].CM centralManagerDidUpdateState:(CBCentralManager *)central
		/*
		if(objDisplayAlert==NULL)
		{
			objDisplayAlert = [[DisplayAlert alloc] init];
			objDisplayAlert.philipsKeyFob  = self;
		}
		 
		[objDisplayAlert setGeneralWarning:@"*" key:ACTION_BLUETOOTH_OFF];
		 */
	}
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    [AppDelegate consoleLog:[NSString stringWithFormat:@"%@ :> %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd)]];
	localNotificationCount = 0;
    app.applicationIconBadgeNumber = localNotificationCount;
}

+ (void)consoleLog:(NSString*)msg
{
	//BOOL LOG_DEBUG_MODE = TRUE;
    if (LOG_DEBUG_MODE)
    {
        NSLog(@"%@",msg);
    }
}


@end
