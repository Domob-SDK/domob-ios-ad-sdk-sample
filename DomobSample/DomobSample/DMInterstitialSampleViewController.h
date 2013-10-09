//
//  DMSecondViewController.h
//  DomobSample
//
//  Copyright (c) 2012年 domob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMInterstitialAdController.h"

@interface DMInterstitialSampleViewController : UIViewController <DMInterstitialAdControllerDelegate>
{
    DMInterstitialAdController *_dmInterstitial;
}

@property (nonatomic, retain) IBOutlet UIButton *presentBtn;

- (IBAction)onPresentBtnClicked:(id)sender;

@end
