//
//  HistorytrackViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//Hud display
#import "MBProgressHUD.h"
//Map View
#import "Pin.h"
#import "CSMapAnnotation.h"
#import "CSImageAnnotationView.h"
#import "CalloutView.h"
//Menu View
#import "YLPopoverMenu.h"
#import "YLMenuItem.h"
//Get Data
#import "Vehiclelocationlist.h"
#import "WelcomeViewController.h"
//URL communication And Parsing
#import "databaseurl.h"
#import "SBJSON.h"
//Custom Alert
#import "TTAlertView.h"
//Custom Date Picker
#import "DateTimePicker.h"
//Custom Search Menu
#import "SearchMenu.h"
//Custom InformationView
#import "HistroytrackInformation.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface HistorytrackViewController : UIViewController<MKMapViewDelegate,MKAnnotation,MBProgressHUDDelegate>
{
    NSMutableArray *locationlist;
    MBProgressHUD *HUD;
    NSMutableArray *distanceValues;

}
- (MKCoordinateRegion)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;


@property (retain, nonatomic) IBOutlet MKMapView *mapview;
@property (retain, nonatomic) IBOutlet UISegmentedControl *maptype;
@property (retain, nonatomic) IBOutlet UIStepper *stepper;
@property (retain, nonatomic)IBOutlet NSString *SelectedDate;
@property (retain, nonatomic)IBOutlet NSString *FromTime;
@property (retain, nonatomic)IBOutlet NSString *ToTime;

@property(retain,nonatomic)IBOutlet NSLayoutConstraint *mapheightConstraint;

@end
