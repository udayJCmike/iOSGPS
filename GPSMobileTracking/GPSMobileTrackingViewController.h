//
//  GPSMobileTrackingViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "BusNameList.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "TTAlertView.h"
#import "GPSMobileTrackingAppDelegate.h"

#define  AppDelegate (GPSMobileTrackingAppDelegate *)[[UIApplication sharedApplication] delegate]
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface GPSMobileTrackingViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate,TTAlertViewDelegate, UIAlertViewDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
{
MBProgressHUD *HUD;
  
}


@property (strong, nonatomic) IBOutlet UIView *LoginView;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UIButton *login;
@property (retain, nonatomic) IBOutlet UIButton *reset;
-(void)LoginWithSession;
-(void)getVehicleList;
@end
