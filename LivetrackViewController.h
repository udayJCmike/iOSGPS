//
//  LivetrackViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Pin.h"
#import "CalloutView.h"
#import "YLPopoverMenu.h"
#import "YLMenuItem.h"
#import "InformationVC.h"
@class CSWebDetailsViewController;
@interface LivetrackViewController : UIViewController<MKMapViewDelegate,MKAnnotation,MKOverlay,CLLocationManagerDelegate,YLPopoverMenuDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *locationlist;
    NSTimer *timer;
    NSTimer *CountDownTimer;
    int TotalSec;
    NSArray *colorArray;
}
@property(nonatomic,retain)NSTimer *timer;

@property (retain, nonatomic) IBOutlet MKMapView *mapview;
@property (retain, nonatomic) IBOutlet UISegmentedControl *maptype;
@property (retain, nonatomic) IBOutlet UIStepper *stepper;
@property(retain, nonatomic)  UIColor *currentLineColor;
@property(retain,nonatomic)IBOutlet NSLayoutConstraint *mapheightConstraint;
@end
