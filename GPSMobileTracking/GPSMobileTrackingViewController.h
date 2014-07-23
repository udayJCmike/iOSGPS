//
//  GPSMobileTrackingViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "TTAlertView.h"


@interface GPSMobileTrackingViewController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate,TTAlertViewDelegate, UIAlertViewDelegate,UINavigationBarDelegate,UINavigationControllerDelegate>
{
MBProgressHUD *HUD;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
- (IBAction)login:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UIButton *login;
@property (retain, nonatomic) IBOutlet UIButton *reset;

@end
