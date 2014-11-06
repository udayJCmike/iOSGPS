//
//  TheftAlarmViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 04/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseurl.h"
#import "TTAlertView.h"
#import "MBProgressHUD.h"
#import "WelcomeViewController.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface TheftAlarmViewController : UIViewController<MBProgressHUDDelegate>
{
    
    MBProgressHUD *HUD;
   
}
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (retain, nonatomic) IBOutlet UIButton *home;
@property (retain, nonatomic) IBOutlet UIButton *logout;
@property (retain, nonatomic) IBOutlet UIImageView *bgimage;
@property (retain, nonatomic) IBOutlet UISwitch *alarmswitch;
@property (retain, nonatomic) IBOutlet UILabel *switchres;
@property (retain, nonatomic) IBOutlet UILabel *alertblink;
@property (retain, nonatomic) IBOutlet UISegmentedControl *onoff;
@end
