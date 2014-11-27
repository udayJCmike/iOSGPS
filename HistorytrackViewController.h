//
//  HistorytrackViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomDatePicker.h"
#import "MBProgressHUD.h"
#import "Pin.h"

@interface HistorytrackViewController : UIViewController<MKMapViewDelegate,MKAnnotation,MBProgressHUDDelegate>
{
    NSMutableArray *locationlist;
    MBProgressHUD *HUD;
    

}
- (MKCoordinateRegion)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (retain, nonatomic) IBOutlet MKMapView *mapview;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UISegmentedControl *maptype;
@property (retain, nonatomic) IBOutlet UIStepper *stepper;
@property (retain, nonatomic) IBOutlet UIButton *home;
@property (retain, nonatomic) IBOutlet UIButton *logout;

@property(retain,nonatomic)IBOutlet NSLayoutConstraint *mapheightConstraint;
@property (retain, nonatomic) IBOutlet UILabel *fromtime;
@property (retain, nonatomic) IBOutlet UILabel *totime;
@property (retain, nonatomic) IBOutlet UILabel *selecteddate;
@property (retain, nonatomic) IBOutlet UIButton *from;
@property (retain, nonatomic) IBOutlet UIButton *to;
@property (retain, nonatomic) IBOutlet UIButton *s_date;
@property (retain, nonatomic) IBOutlet UIButton *search;
@end
