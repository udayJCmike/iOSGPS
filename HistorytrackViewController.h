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
@property (retain, nonatomic) IBOutlet UIView *view1;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *welcome;
@property (retain, nonatomic) IBOutlet MKMapView *mapview;
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet UISegmentedControl *maptype;
@property (retain, nonatomic) IBOutlet UIStepper *stepper;
@property (retain, nonatomic) IBOutlet UIButton *home;
@property (retain, nonatomic) IBOutlet UIButton *logout;
@property (retain, nonatomic) IBOutlet CustomDatePicker* _customPicker;
@property(retain,nonatomic)IBOutlet NSLayoutConstraint *mapheightConstraint;
@end
