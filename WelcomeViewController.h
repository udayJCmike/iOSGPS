//
//  WelcomeViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#define  AppDelegate (GPSMobileTrackingAppDelegate *)[[UIApplication sharedApplication] delegate]
@interface WelcomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
{
IBOutlet UITableView *tableView;
NSMutableArray *list;
    MBProgressHUD *HUD;
}
- (IBAction)about:(id)sender;
- (IBAction)contact:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UIButton *logout;
@property (retain, nonatomic) IBOutlet UIButton *aboutus;
@property (retain, nonatomic) IBOutlet UIButton *contactus;
@property(retain,nonatomic)IBOutlet NSLayoutConstraint *tableheightConstraint;

@end
