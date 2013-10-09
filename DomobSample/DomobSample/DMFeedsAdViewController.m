//
//  DMFeedsAdViewController.m
//  DomobSample
//
//  Copyright (c) 2013年 domob. All rights reserved.
//

#import "DMFeedsAdViewController.h"

#define DM_PUBLISHER_ID @"56OJyM1ouMGoULfJaL"
#define DM_PLACEMENT_ID @"16TLwebvAchkANUH_krQ7vOz"

@interface DMFeedsAdViewController ()

@end

@implementation DMFeedsAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"FeedsAdView", @"FeedsAdView");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGPoint origin = CGPointMake(0, 0);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        origin = CGPointMake(0, 20);
    }
    
    if (_dmFeedsAdView == nil) {
        
        _dmFeedsAdView = [[DMFeedsAdView alloc]initWithPublisherId:DM_PUBLISHER_ID
                                                       placementId:DM_PLACEMENT_ID
                                                            origin:origin];
        
        _dmFeedsAdView.delegate = self;
        _dmFeedsAdView.rootViewController = self;
        
        //开始请求广告 request ad
        [_dmFeedsAdView loadAd];
    }
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.tintColor = [UIColor lightGrayColor];
    refresh.attributedTitle = [[[NSAttributedString alloc]
                                    initWithString:@"Pull to Refresh"] autorelease];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    [refresh release];
    
}

- (void)refreshView:(UIRefreshControl *)refreshControl
{
    //调用下拉刷新时 present if ready show ad
    [_dmFeedsAdView present];
    [self performSelector:@selector(stop:) withObject:refreshControl afterDelay:3];
    
}
- (void)stop:(UIRefreshControl *)refreshControl
{
    [self.refreshControl endRefreshing];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%d 点我可关闭信息流广告",[indexPath row]];
    }
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //手动关闭信息流广告 close the ad by yourself if needed
    [_dmFeedsAdView closeAd];
}

#pragma mark - DMFeedsAdView delegate
- (void)dmFeedsSuccessToLoadAd:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] success to load.");
}
- (void)dmFeedsFailToLoadAd:(DMFeedsAdView *)dmFeeds withError:(NSError *)err
{
    NSLog(@"[Domob FeedsAdView] failed to load.");
    //推荐在失败后再调用一遍 load again if failed
    [_dmFeedsAdView loadAd];
}
- (void)dmFeedsDidClicked:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] did click.");
}
- (void)dmFeedsWillPresentModalView:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] will present modal view.");
}
- (void)dmFeedsDidDismissModalView:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] did dismiss modal view.");
}
- (void)dmFeedsApplicationWillEnterBackground:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] will enter background.");
}
- (void)dmFeedsWillPresentScreen:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] will present screen.");
}
- (void)dmFeedsDidDismissScreen:(DMFeedsAdView *)dmFeeds
{
    NSLog(@"[Domob FeedsAdView] did dismiss screen.");
}


@end
