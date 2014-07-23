//
//  alertmessageViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "TTAlertView.h"

@interface alertmessageViewController : UIViewController<UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)sendMessageAction:(UIButton *)sender;
- (IBAction)clearMessageAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *home;
@property (retain, nonatomic) IBOutlet UIButton *logout;
@property (retain, nonatomic) IBOutlet UITextView *alertMessageTextView;
@property (retain, nonatomic) IBOutlet UIButton *sendmessage;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *textwidth;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (retain, nonatomic) IBOutlet UIButton *clearmessage;
@end
