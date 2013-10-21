//
//  DMFeedsAdViewController.m
//  DomobAdSDK
//  Use EGORefreshTableHeaderView for pull refresh tableView
//  Copyright (c) 2013年 Domob Ltd. All rights reserved.
//

#import "DMFeedsAdViewController.h"


#define DM_PUBLISHER_ID @"56OJyM1ouMGoULfJaL"
#define DM_PLACEMENT_ID @"16TLwebvAchkANUGSzRHJYcs"

@interface DMFeedsAdViewController ()
{
    CGPoint origin;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

//method
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end

@implementation DMFeedsAdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    origin = CGPointMake(0, 0);
    if (!([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)) {
        origin = CGPointMake(0, 20);
        // do not forget if there is a statusBar down 20 pixels height in iOS 7.
        self.myTable.frame = CGRectMake(origin.x,
                                        origin.y,
                                        self.view.frame.size.width,
                                        self.view.frame.size.height);
    }
     /**feeds ad view  **/
    _feedsView = [[DMFeedsAdView alloc]initWithPublisherId:DM_PUBLISHER_ID
                                               placementId:DM_PLACEMENT_ID
                                                    origin:CGPointMake(0, 20)];

    _feedsView.rootViewController = self;
    _feedsView.delegate = self;
    
    [_feedsView loadAd];
    
    
    /** refresh view  **/
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]
                                           initWithFrame:CGRectMake(0.0f,0.0f - _feedsView.frame.size.height,
                                                                                  self.view.frame.size.width,
                                                                                _feedsView.frame.size.height)];
		view.delegate = self;
		[self.myTable addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}

    //  refresh view update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Feeds", @"Feeds");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(closeFeedsAdView)
                                                     name:@"closeFeedsAdView"
                                                   object:nil];


    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	return [NSString stringWithFormat:@"Section %i", section];
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // close the ad view by yourself
    [_feedsView closeAd];
}
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    
    /** 竖屏情况开始展现广告
     present feeds ad view
     please choose the orientation you support
     UIDeviceOrientationPortrait/UIDeviceOrientationPortraitUpsideDown   **/
    
    if ([[UIApplication sharedApplication] statusBarOrientation]
                                          == UIInterfaceOrientationPortrait)
    {
        [_feedsView present];
    }

    
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTable];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}
#pragma mark -
#pragma mark closeFeedsAdmethod by yourself
- (void)closeFeedsAdView
{
    [_feedsView closeAd];
}
#pragma mark 
#pragma mark FeedsAdViewDelegate
- (void)dmFeedsSuccessToLoadAd:(DMFeedsAdView *)dmFeeds
{
    NSLog(@" [Domob FeedsAdView] SuccessToLoadAd");
}
- (void)dmFeedsFailToLoadAd:(DMFeedsAdView *)dmFeeds withError:(NSError *)err
{
     NSLog(@" [Domob FeedsAdView] FailToLoadAd");
}
- (void)dmFeedsDidClicked:(DMFeedsAdView *)dmFeeds
{
     NSLog(@" [Domob FeedsAdView] DidClicked");
}

// Feeds广告生命周期的回调
- (void)dmFeedsWillPresentScreen:(DMFeedsAdView *)dmFeeds
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.myTable setFrame:CGRectMake(origin.x,
                                      self.feedsView.frame.size.height+origin.y,
                                      self.myTable.frame.size.width,
                                      self.myTable.frame.size.height)];
	[UIView commitAnimations];

}
- (void)dmFeedsDidDismissScreen:(DMFeedsAdView *)dmFeeds
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[self.myTable setFrame:CGRectMake(origin.x,
                                      origin.y,
                                      self.myTable.frame.size.width,
                                      self.myTable.frame.size.height)];
	[UIView commitAnimations];
    //load ad when the ad view dismiss
    [_feedsView loadAd];
}

// 由于用户对广告的操作引发的事件回调
- (void)dmFeedsWillPresentModalView:(DMFeedsAdView *)dmFeeds
{
     NSLog(@" [Domob FeedsAdView] WillPresentModalView");
}
- (void)dmFeedsDidDismissModalView:(DMFeedsAdView *)dmFeeds
{
     NSLog(@" [Domob FeedsAdView] DidDismissModalView");
}
- (void)dmFeedsApplicationWillEnterBackground:(DMFeedsAdView *)dmFeeds
{
     NSLog(@" [Domob FeedsAdView] WillEnterBackground");
}

#pragma mark
#pragma mark Orientation method

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //close the ad view by yourself
    [_feedsView closeAd];
}


- (void)dealloc {
    
    _feedsView.delegate = nil;
    [_feedsView release];
    [_refreshHeaderView release];
    self.myTable = nil;
    
    [super dealloc];
}

@end
