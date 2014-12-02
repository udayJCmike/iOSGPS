//
//  OverSpeedViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 05/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseurl.h"
#import "TTAlertView.h"
#import "MBProgressHUD.h"
#import "WelcomeViewController.h"
#import "YLPopoverMenu.h"
#import "YLMenuItem.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)

@interface OverSpeedViewController : UIViewController<MBProgressHUDDelegate>
{
    
    MBProgressHUD *HUD;
    BOOL fullyOpen;
}



@property (retain, nonatomic)  NSString *fromdate;
@property (retain, nonatomic)  NSString *todate;
@property (retain, nonatomic) IBOutlet UILabel *vecnumber;
@property (retain, nonatomic) IBOutlet UILabel *drivername;
@property (retain, nonatomic) IBOutlet UILabel *speedcount;
@property (retain, nonatomic) IBOutlet UILabel *ownername;
@property (retain, nonatomic) IBOutlet UILabel *devicestatus;

@end
