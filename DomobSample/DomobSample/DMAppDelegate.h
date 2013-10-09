//
//  DMAppDelegate.h
//  DomobSample
//
//  Copyright (c) 2012年 domob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMSplashAdController.h"
#import "DMRTSplashAdController.h"

@interface DMAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, DMSplashAdControllerDelegate>
{
    DMSplashAdController *_splashAd;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
