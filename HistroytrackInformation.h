//
//  HistroytrackInformation.h
//  DeemGPS
//
//  Created by DeemsysInc on 29/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif
@interface HistroytrackInformation : UIView
{
    UIView*v1,*v2;
    UIView *greyView;
    UIView *popUpView;
    int interval;
    NSTimer *CountDownTimer;
    int TotalSec;
    UINavigationBar *navbar;
}
@property (retain, nonatomic) IBOutlet UIButton *close;

@property (retain, nonatomic) IBOutlet UILabel *vecreg;
@property (retain, nonatomic) IBOutlet UILabel *vecreg_ans;
@property (retain, nonatomic) IBOutlet UILabel *ownername;
@property (retain, nonatomic) IBOutlet UILabel *ownername_ans;
@property (retain, nonatomic) IBOutlet UILabel *totalDistance;
@property (retain, nonatomic) IBOutlet UILabel *totalDistance_ans;
@property (retain, nonatomic) IBOutlet UILabel *instruction;
@property (retain, nonatomic) IBOutlet UILabel *red_lab;
@property (retain, nonatomic) IBOutlet UILabel *green_lab;
@property (retain, nonatomic) IBOutlet UILabel *pink_lab;
@property (retain, nonatomic) IBOutlet UIImageView *red;
@property (retain, nonatomic) IBOutlet UIImageView *green;
@property (retain, nonatomic) IBOutlet UIImageView *pink;
@property (retain, nonatomic) IBOutlet UIImageView *indi_bg;

@property (assign) float xOffset;

@property (assign) float yOffset;

@end
