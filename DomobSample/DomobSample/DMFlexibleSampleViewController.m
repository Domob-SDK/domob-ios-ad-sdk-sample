//
//  DMFlexibleSampleViewController.m
//  DomobSample
//
//  Copyright (c) 2013年 domob. All rights reserved.
//

#import "DMFlexibleSampleViewController.h"
#import "DMTools.h"

#define DM_PUBLISHER_ID @"56OJyM1ouMGoULfJaL"
#define DM_PLACEMENT_ID @"16TLwebvAchkANUH_krQ7vOz"

@interface DMFlexibleSampleViewController ()
{
    CGPoint origin;
}

@end

@implementation DMFlexibleSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Flexible", @"Flexible");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        origin = CGPointMake(0, 0);
        if (!([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)) {
            origin = CGPointMake(0, 20);
        }
    }
    return self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // 创建广告视图，此处使用的是测试ID，请登陆多盟官网（www.domob.cn）获取新的ID
    // Creat advertisement view please get your own ID from domob website
    _dmFlexibleAdView = [[DMAdView alloc] initWithPublisherId:DM_PUBLISHER_ID
                                                  placementId:DM_PLACEMENT_ID
                                                         size:FLEXIBLE_SIZE_PORTRAIT];
    // 设置广告视图的位置
    // Set the frame of advertisement view
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        _dmFlexibleAdView.frame = CGRectMake(origin.x,
                                             origin.y,
                                             FLEXIBLE_SIZE_LANDSCAPE.width,
                                             FLEXIBLE_SIZE_LANDSCAPE.height);
    }
    else
    {
        _dmFlexibleAdView.frame = CGRectMake(origin.x,
                                             origin.y,
                                             FLEXIBLE_SIZE_PORTRAIT.width,
                                             FLEXIBLE_SIZE_PORTRAIT.height);
        
    }
    
    _dmFlexibleAdView.delegate = self;
    _dmFlexibleAdView.rootViewController = self; // set RootViewController
    [self.view addSubview:_dmFlexibleAdView];
    [_dmFlexibleAdView loadAd]; // start load advertisement
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    _dmFlexibleAdView.delegate = nil;
    _dmFlexibleAdView.rootViewController = nil;
    [_dmFlexibleAdView removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //针对横竖屏 设定对应的FlexibleView的frame
    //set right frame for FlexibleView
    if (UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)){
        
        _dmFlexibleAdView.frame = CGRectMake(_dmFlexibleAdView.frame.origin.x,
                                             _dmFlexibleAdView.frame.origin.y,
                                             FLEXIBLE_SIZE_PORTRAIT.width,
                                             FLEXIBLE_SIZE_PORTRAIT.height);
        
    }else{
        
        _dmFlexibleAdView.frame = CGRectMake(_dmFlexibleAdView.frame.origin.x,
                                             _dmFlexibleAdView.frame.origin.y,
                                             FLEXIBLE_SIZE_LANDSCAPE.width,
                                             FLEXIBLE_SIZE_LANDSCAPE.height);
        
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _dmFlexibleAdView.delegate = nil;
    _dmFlexibleAdView.rootViewController = nil;
    [_dmFlexibleAdView release];
    
    [super dealloc];
}
#pragma mark -
#pragma mark DMAdView delegate

// 成功加载广告后，回调该方法
// This method will be used after load successfully
- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    NSLog(@"[Domob Flexible] success to load ad.");
}

// 加载广告失败后，回调该方法
// This method will be used after load failed
- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    NSLog(@"[Domob Flexible] fail to load ad. %@", error);
}

// 当将要呈现出 Modal View 时，回调该方法。如打开内置浏览器
// When will be showing a Modal View, this method will be called. Such as open built-in browser
- (void)dmWillPresentModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Flexible] will present modal view.");
}

// 当呈现的 Modal View 被关闭后，回调该方法。如内置浏览器被关闭。
// When presented Modal View is closed, this method will be called. Such as built-in browser is closed
- (void)dmDidDismissModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Flexible] did dismiss modal view.");
}

// 当因用户的操作（如点击下载类广告，需要跳转到Store），需要离开当前应用时，回调该方法
// When the result of the user's actions
//(such as clicking download class advertising, you need to jump to the Store), need to leave the current application, this method will be called
- (void)dmApplicationWillEnterBackgroundFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Flexible] will enter background.");
}


@end
