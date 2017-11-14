//
//  AppDelegate.m
//  nightLight
//
//  Created by leo on 17/1/20.
//  Copyright © 2017年 Tang Yuan L inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initAppConfig];
    
    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [self loadNavigationBar];
    return YES;
}

-(void)initAppConfig{
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"fitst"] == -2){
        
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDict objectForKey:@"CFBundleVersion"];
        if([version isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kVersionNumber]]){
            //版本号没有变 不管
        }else{
            
            //用户升级了
        }
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:kVersionNumber];
        
    }else{
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDict objectForKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:kVersionNumber];
        [[NSUserDefaults standardUserDefaults] setInteger:-2 forKey:@"fitst"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:3*60] forKey:kTimeValue];
        
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:[UIColor whiteColor]];
        [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:kScreenColor];
        
        //[[NSUserDefaults standardUserDefaults] setObject:[UIColor whiteColor] forKey:kScreenColor];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 设置navigationbar
-(void)loadNavigationBar{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:81.0/255 green:48.0/255 blue:12.0/255 alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"login_back.png"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"login_back.png"]];
    
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont boldSystemFontOfSize:18] forKey:NSFontAttributeName];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
}

@end
