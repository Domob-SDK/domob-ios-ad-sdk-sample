//
//  DMFeedsAdViewController.h
//  DomobSample
//
//  Copyright (c) 2013年 domob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFeedsAdView.h"

@interface DMFeedsAdViewController : UITableViewController<DMFeedsAdViewDelegate>
{
    BOOL _reloading;
    DMFeedsAdView *_dmFeedsAdView;
}
@property (nonatomic, retain) DMFeedsAdView *dmFeedsAdView;
@end
