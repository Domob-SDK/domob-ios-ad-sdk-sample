//
//  DMFirstViewController.m
//  DomobSample
//
//  Copyright (c) 2012年 domob. All rights reserved.
//

#import "DMInlineSampleViewController.h"
#import "DMTools.h"

#define DMPUBLISHERID        @"56OJyM1ouMGoULfJaL"
#define DMPLCAEMENTID_BANNER @"16TLwebvAchkANUH_krQ7vOz"

@interface DMInlineSampleViewController ()
{
    CGSize _adSize;
    CGFloat _adX, _adY;
}
@end

@implementation DMInlineSampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Inline", @"Inline");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        // 确定广告尺寸及位置
        //Set the size and origin
        _adX = 0;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
         
            if (!([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)) {
                
                _adY = 20;
                
            }else{
                
            }
            
        }
        else
        {
    
            _adY = 20;
        }
        
        
    }
    return self;
}

- (void)dealloc
{
    _dmAdView.delegate = nil;
    _dmAdView.rootViewController = nil;
    [_dmAdView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // 创建广告视图，此处使用的是测试ID，请登陆多盟官网（www.domob.cn）获取新的ID
    // Creat advertisement view please get your own ID from domob website
#warning please change the DMPUBLISHERID and the DMPLCAEMENTID_BANNER
    _dmAdView = [[DMAdView alloc] initWithPublisherId:DMPUBLISHERID
                                          placementId:DMPLCAEMENTID_BANNER];
    
    // 设置广告视图的位置 宽与高设置为0即可 该广告视图默认是横竖屏自适应 但需要在旋转时调用orientationChanged 方法
    // Set the frame of advertisement view
    _dmAdView.frame = CGRectMake(_adX, _adY, FLEXIBLE_SIZE.width,FLEXIBLE_SIZE.height);
    _dmAdView.delegate = self;
    _dmAdView.rootViewController = self; // set RootViewController
    [self.view addSubview:_dmAdView];
    [_dmAdView loadAd]; // start load advertisement
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    // 检查评价提醒，此处使用的是测试ID，请登陆多盟官网（www.domob.cn）获取新的ID
    // Check for rate please get your own ID from Domob website
#warning please change the DMPUBLISHERID
    DMTools *_dmTools = [[DMTools alloc] initWithPublisherId:DMPUBLISHERID];
    [_dmTools checkRateInfo];
    [_dmTools release];
    
}

//针对Banner的横竖屏自适应方法
//method For multible orientation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [_dmAdView orientationChanged];
}

#pragma mark -
#pragma mark DMAdView delegate

// 成功加载广告后，回调该方法
// This method will be used after load successfully
- (void)dmAdViewSuccessToLoadAd:(DMAdView *)adView
{
    NSLog(@"[Domob Sample] success to load ad.");
}

// 加载广告失败后，回调该方法
// This method will be used after load failed
- (void)dmAdViewFailToLoadAd:(DMAdView *)adView withError:(NSError *)error
{
    NSLog(@"[Domob Sample] fail to load ad. %@", error);
}

// 当将要呈现出 Modal View 时，回调该方法。如打开内置浏览器
// When will be showing a Modal View, this method will be called. Such as open built-in browser
- (void)dmWillPresentModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Sample] will present modal view.");
}

// 当呈现的 Modal View 被关闭后，回调该方法。如内置浏览器被关闭。
// When presented Modal View is closed, this method will be called. Such as built-in browser is closed
- (void)dmDidDismissModalViewFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Sample] did dismiss modal view.");
}

// 当因用户的操作（如点击下载类广告，需要跳转到Store），需要离开当前应用时，回调该方法
// When the result of the user's actions (such as clicking download class advertising, you need to jump to the Store), need to leave the current application, this method will be called
- (void)dmApplicationWillEnterBackgroundFromAd:(DMAdView *)adView
{
    NSLog(@"[Domob Sample] will enter background.");
}

@end
