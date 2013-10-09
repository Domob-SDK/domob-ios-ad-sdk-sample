//
//  DMFirstViewController.h
//  DomobSample
//
//  Copyright (c) 2012年 domob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMAdView.h"
@interface DMInlineSampleViewController : UIViewController <DMAdViewDelegate>
{
    DMAdView *_dmAdView;
}

@end
