//
//  DMAppDelegate.m
//  DomobSample
//
//  Copyright (c) 2012年 domob. All rights reserved.
//

#import "DMAppDelegate.h"
#import "DMInlineSampleViewController.h"
#import "DMInterstitialSampleViewController.h"
#import "DMFlexibleSampleViewController.h"
#import "DMFeedsAdViewController.h"

@implementation DMAppDelegate

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.delegate = self;
    UIViewController *viewController1, *viewController2,*viewController3,*viewController4;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[[DMInlineSampleViewController alloc]
                            initWithNibName:@"DMInlineSampleViewController_iPhone"
                            bundle:nil] autorelease];
        viewController2 = [[[DMInterstitialSampleViewController alloc]
                            initWithNibName:@"DMInterstitialSampleViewController_iPhone"
                            bundle:nil] autorelease];
        viewController3 = [[[DMFlexibleSampleViewController alloc]
                            initWithNibName:@"DMFlexibleSampleViewController_iPhone"
                            bundle:nil] autorelease];
        viewController4 = [[[DMFeedsAdViewController alloc]
                            initWithNibName:@"DMFeedsAdViewController"
                            bundle:nil] autorelease];
        
        self.tabBarController.viewControllers = @[viewController1, viewController2,viewController3,viewController4];
    } else {
        viewController1 = [[[DMInlineSampleViewController alloc]
                            initWithNibName:@"DMInlineSampleViewController_iPad"
                            bundle:nil] autorelease];
        viewController2 = [[[DMInterstitialSampleViewController alloc]
                            initWithNibName:@"DMInterstitialSampleViewController_iPad"
                            bundle:nil] autorelease];
        viewController3 = [[[DMFlexibleSampleViewController alloc]
                            initWithNibName:@"DMFlexibleSampleViewController_iPad"
                            bundle:nil] autorelease];
        self.tabBarController.viewControllers = @[viewController1, viewController2,viewController3];
    }
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    // 设置适合的背景图片
    // Set background image
    NSString *defaultImgName = @"Default";
    CGFloat offset = 0.0f;
    CGSize adSize;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        adSize = DOMOB_AD_SIZE_768x576;
        defaultImgName = @"Default-Portrait";
        offset = 374.0f;
    } else {
        adSize = DOMOB_AD_SIZE_320x400;
        if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
            defaultImgName = @"Default-568h";
            offset = 233.0f;
        } else {
            offset = 168.0f;
        }
    }
    
    BOOL isCacheSplash = NO;
    // 选择测试缓存开屏还是实时开屏，NO为实时开屏。
    // Choose NO or YES for RealTimeSplashView or SplashView
    // 初始化开屏广告控制器，此处使用的是测试ID，请登陆多盟官网（www.domob.cn）获取新的ID
    // Get your ID from Domob website
    NSString* testPubID = @"56OJyM1ouMGoULfJaL";
    NSString* testSplashPlacementID = @"16TLwebvAchkAY6iOVhpfHPs";
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:defaultImgName]];
    if (isCacheSplash) {
        _splashAd = [[DMSplashAdController alloc] initWithPublisherId:testPubID
                                                          placementId:testSplashPlacementID
                                                                 size:adSize
                                                               offset:offset
                                                               window:self.window
                                                           background:bgColor
                                                            animation:YES];
        _splashAd.delegate = self;
        if (_splashAd.isReady)
        {
            [_splashAd present];
        }
        [_splashAd release];
    } else {
        DMRTSplashAdController* rtsplashAd = nil;
        rtsplashAd = [[DMRTSplashAdController alloc] initWithPublisherId:@"56OJyM1ouMGoULfJaL"//@"56OJy3zouMZM2KpAFd"
                                                             placementId:@"16TLwebvAchkAY6iOVhpfHPs"
                                                                    size:adSize
                                                                  offset:233.5f
                                                                  window:self.window
                                                              background:bgColor
                                                               animation:YES];
        
        
        rtsplashAd.delegate = self;
        [rtsplashAd present];
        [rtsplashAd release];
    }
    
    return YES;
}

- (BOOL)isPad {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 3.2f)
    {
        return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? YES : NO;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
     if (![viewController isKindOfClass:[DMFeedsAdViewController class]]) {
         
         [[NSNotificationCenter defaultCenter] postNotification:
          [NSNotification notificationWithName:@"closeFeedsAdView" object:self]];
     }

 }


/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

#pragma mark -
#pragma makr Domob Splash Ad Delegate
//成功加开屏广告后调用
//This method will be used after load splash advertisement successfully
- (void)dmSplashAdSuccessToLoadAd:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] success to load ad.");
}

// 当开屏广告加载失败后，回调该方法
// This method will be used after load splash advertisement faild
- (void)dmSplashAdFailToLoadAd:(DMSplashAdController *)dmSplashAd withError:(NSError *)err
{
    NSLog(@"[Domob Splash] fail to load ad.");
}

// 当插屏广告要被呈现出来前，回调该方法
// This method will be used before the splashView will show
- (void)dmSplashAdWillPresentScreen:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] will appear on screen.");
}

// 当插屏广告被关闭后，回调该方法
// This method will be used after the splashView dismiss
- (void)dmSplashAdDidDismissScreen:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] did disappear on screen.");
}

@end
