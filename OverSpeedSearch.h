//
//  OverSpeedSearch.h
//  DeemGPS
//
//  Created by DeemsysInc on 29/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateTimePicker.h"
#import "TTAlertView.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

@interface OverSpeedSearch : UIView
{
    UIView *greyView;
    UIView *popUpView;
    DateTimePicker *picker;
}



@property (retain, nonatomic) IBOutlet UIButton *search;

@property (retain, nonatomic) IBOutlet UILabel *fromTime;
@property (retain, nonatomic) IBOutlet UILabel *toTime;

@property (retain, nonatomic) IBOutlet UIButton *fromButton;
@property (retain, nonatomic) IBOutlet UIButton *toButton;


@property (assign) float xOffset;

@property (assign) float yOffset;



@property (nonatomic) float handleHeight;
@property (nonatomic) float animationDuration;
@property (nonatomic) float topMarginPortrait;
@property (nonatomic) float topMarginLandscape;


@property (nonatomic) UIFont *cellFont;
@property (nonatomic) float cellHeight;
@property (nonatomic) BOOL fullyOpen;



@end
