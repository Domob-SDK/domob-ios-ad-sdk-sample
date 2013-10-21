//
//  DMFeedsAdViewController.h
//  DomobAdSDK
//
//  Copyright (c) 2013年 Domob Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "DMFeedsAdView.h"

@interface DMFeedsAdViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,
                                                        EGORefreshTableHeaderDelegate, DMFeedsAdViewDelegate>


@property (nonatomic, retain) DMFeedsAdView *feedsView;

@property (nonatomic, retain) IBOutlet UITableView *myTable;

@end
