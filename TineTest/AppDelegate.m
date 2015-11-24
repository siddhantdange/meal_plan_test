//
//  AppDelegate.m
//  TineTest
//
//  Created by Siddhant Dange on 11/2/15.
//  Copyright © 2015 Siddhant Dange. All rights reserved.
//

#import "AppDelegate.h"
#import "TNOrder.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) TNOrder *currentOrder;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    self.currentOrder = [[TNOrder alloc] init];
    
    return YES;
}

-(UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _window;
}

-(UINavigationController *)navigationController {
    if (!_navigationController) {
        self.mvc = [[MainViewController alloc] initWithNibName:@"MainView" bundle:[NSBundle mainBundle] order:self.currentOrder];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.mvc];
    }
    
    return _navigationController;
}

- (TNOrder *)currentOrder {
    if (!_currentOrder) {
        _currentOrder = [[TNOrder alloc] init];
    }
    
    return _currentOrder;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
