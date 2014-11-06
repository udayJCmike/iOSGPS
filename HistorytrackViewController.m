//
//  HistorytrackViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "HistorytrackViewController.h"
#import "Vehiclelocationlist.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "TTAlertView.h"
#import "WelcomeViewController.h"
#import "CSMapAnnotation.h"
#import "CSImageAnnotationView.h"
#import "CalloutView.h"
#import "DateTimePicker.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)

@interface HistorytrackViewController ()
{
    databaseurl *du;
    float stepper_initial_value;
        DateTimePicker *picker;
    
}
@property (nonatomic, strong) NSMutableArray *allPins;
@property (nonatomic, strong) MKPolylineView *lineView;
@property (nonatomic, strong) MKPolyline *polyline;

- (IBAction)drawLines:(id)sender;

@end

@implementation HistorytrackViewController
@synthesize search;
@synthesize stepper;
@synthesize maptype;
@synthesize segment;
@synthesize welcome;
@synthesize mapview;
@synthesize imageview;
@synthesize from;
@synthesize fromtime;
@synthesize to;
@synthesize totime;
@synthesize selecteddate;
@synthesize s_date;
@synthesize home;
@synthesize logout;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)zoomMapinc:(MKMapView*)mapView byDelta:(float) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta*=delta;
    span.longitudeDelta*=delta;
    region.span=span;
    [mapView setRegion:region animated:YES];
    
}
- (void)zoomMapdec:(MKMapView*)mapView byDelta:(float) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta/=delta;
    span.longitudeDelta/=delta;
    region.span=span;
    [mapView setRegion:region animated:YES];
    
}
- (IBAction)maptype:(id)sender {
    if (maptype.selectedSegmentIndex==0) {
        mapview.mapType=MKMapTypeStandard;
    }
    else
    {
       mapview.mapType=MKMapTypeSatellite;
    }
}
- (IBAction)zoom:(id)sender {
    if (stepper.value > stepper_initial_value) {
        stepper_initial_value=stepper.value;
        [self zoomMapdec:self.mapview byDelta:2.0];
        
    }
    else if (stepper.value < stepper_initial_value)
    {
       stepper_initial_value=stepper.value;
        [self zoomMapinc:self.mapview byDelta:2.0];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == welcome && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =98;
            }
            if (con.firstItem == home && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 74;
            }
            if (con.firstItem == logout && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 102;
            }
            if (con.firstItem == segment && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =124;
            }
            if (con.firstItem == selecteddate && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 148;
            }
            if (con.firstItem == s_date && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 148;
            }
            if (con.firstItem == fromtime && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 150;
            }
            if (con.firstItem == from && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 150;
            }
            if (con.firstItem == totime && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 150;
            }
            if (con.firstItem == to && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 150;
            }
            if (con.firstItem == search && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 146;
            }
            if (con.firstItem == stepper && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 435;
                
            }
            if (con.firstItem == maptype && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =435;
            }
            if (con.firstItem == mapview && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =172;
                self.mapheightConstraint.constant = 302;
                [self.mapview needsUpdateConstraints];
            }
            
        }
    }

    
    NSString *role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    
    if ([role isEqualToString:@"ROLE_ADMIN"]) {
           [segment removeSegmentAtIndex:3 animated:YES];
    }
    else  if (([role isEqualToString:@"ROLE_PCLIENT"]) ||   ([role isEqualToString:@"ROLE_FCLIENT"]))
    {
       // [segment removeSegmentAtIndex:2 animated:YES];
        [segment setTitle:@"Theft Alarm" forSegmentAtIndex:2];
    }

     self.allPins = [[NSMutableArray alloc]init];
   
      welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Times New Roman" size:20], UITextAttributeFont,nil];
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Times New Roman" size:12], UITextAttributeFont,nil];
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    }
    
    CLLocationCoordinate2D coord = {.latitude =  22.3512639, .longitude =78.9542827};
    MKCoordinateSpan span = {.latitudeDelta =  30, .longitudeDelta =  30};
    //  MKCoordinateRegion region = {coord, span};
    MKCoordinateRegion region = { .center = coord, .span = span };
    
    
    
    [mapview setRegion:region animated:YES];
    [segment setSelectedSegmentIndex:1];
    
    stepper_initial_value=stepper.value;
     
   
    // Do any additional setup after loading the view.
    du=[[databaseurl alloc]init];
    NSString *filename = [du imagecheck:@"historytrack.jpg"];
    NSLog(@"image name %@",filename);
    
    mapview.delegate=self;
    
    imageview.image = [UIImage imageNamed:filename];
    
   
}
- (IBAction)dateClicked:(id)sender {
    
    
    [self cancelPressed];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0,(screenHeight-230), screenWidth, screenHeight/2 + 35)];
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeDate];
        picker.picker.tag=3;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+100, screenWidth, screenHeight/2 + 35)];
        if(SCREEN_35)
        {
            picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+20, screenWidth, screenHeight/2 + 35)];
        }
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeDate];
        picker.picker.tag=3;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"US"];
    [picker.picker setLocale:locale];
}

- (IBAction)fromtimeClicked:(id)sender {
    
    
    [self cancelPressed];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0,(screenHeight-230), screenWidth, screenHeight/2 + 35)];
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=1;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+100, screenWidth, screenHeight/2 + 35)];
        if(SCREEN_35)
        {
            picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+20, screenWidth, screenHeight/2 + 35)];
        }
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=1;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"UK"];
    [picker.picker setLocale:locale];
    
}
-(void)pickerChanged:(id)sender {
    UIDatePicker *dp=(UIDatePicker*)sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *timeDate =[dateFormatter1 stringFromDate:[dp date]];
    if (dp.tag==1) {
        self.fromtime.text = timeDate;
    }
    else if (dp.tag==2) {
        self.totime.text = timeDate;
    }
    else if (dp.tag==3) {
        self.selecteddate.text = strDate;
    }
    
}

-(void)donePressed {
    UIDatePicker *dp=picker.picker;
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *timeDate =[dateFormatter1 stringFromDate:[dp date]];
    if (dp.tag==1) {
        self.fromtime.text = timeDate;
    }
    else if (dp.tag==2) {
        self.totime.text = timeDate;
    }
    else if (dp.tag==3) {
        self.selecteddate.text = strDate;
    }
    [picker removeFromSuperview];
    //    NSLog(@"Done button tapped");
    
}

-(void)cancelPressed {
    [picker removeFromSuperview];
    //    NSLog(@"Cancel pressed");
}

- (IBAction)totimeClicked:(id)sender {
    [self cancelPressed];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0,screenHeight-230, screenWidth, screenHeight/2 + 35)];
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=2;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+100, screenWidth, screenHeight/2 + 35)];
        if(SCREEN_35)
        {
            picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+20, screenWidth, screenHeight/2 + 35)];
        }
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self.view addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=2;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"UK"];
    [picker.picker setLocale:locale];
}

- (IBAction)search:(id)sender {
    if ((![selecteddate.text isEqualToString:@"Select Date"])&&(![fromtime.text isEqualToString:@"From"])&&(![totime.text isEqualToString:@"To"]))
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        HUD.mode=MBProgressHUDModeIndeterminate;
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        [HUD show:YES];
        [self performSelector:@selector(getData) withObject:self afterDelay:0.1f];
       
        

        
    }
    else if ([selecteddate.text isEqualToString:@"Select Date"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    else if ([fromtime.text isEqualToString:@"From"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select From Time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
   else if ([totime.text isEqualToString:@"To"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select To Time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
}


-(void)getData
{
    
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
        
        NSString *response=[self HttpPostEntityFirst1:@"orgid" ForValue1:orgid   EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
        locationlist=[[NSMutableArray alloc]init];
        
        if (parsedvalue == nil)
        {
            
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            NSArray *datas=[menu objectForKey:@"vehiclehistory List"];
            
            
            //     To check whether its having data or not
            //              NSLog(@"datas %lu",(unsigned long)[datas count]);
            
            if ([datas count]>0)
            {
                
                for (id anUpdate1 in datas)
                {
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
                    
                    Vehiclelocationlist *list1=[[Vehiclelocationlist alloc]init];
                    list1.latitude=[arrayList1 objectForKey:@"latitude"];
                    list1.longitude =[arrayList1 objectForKey:@"longitude"];
                    list1.speed =[arrayList1 objectForKey:@"speed"];
                    list1.exceed_speed_limit =[arrayList1 objectForKey:@"exceed_speed_limit"];
                    list1.bus_tracking_timestamp =[arrayList1 objectForKey:@"bus_tracking_timestamp"];
                    list1.address =[arrayList1 objectForKey:@"address"];
                    
                    list1.flag=[arrayList1 objectForKey:@"flag"];
                    [locationlist addObject:list1];
                    
                    
                }
                [self setpin];
                
            }
            else
            {
                 [HUD hide:YES];
                NSUInteger componentFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
                NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:[NSDate date]];
                NSInteger value=[components year];
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",(int)value]  forKey:@"year"];
                
                NSInteger value1=[components month];
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",(int)value1]  forKey:@"month"];
                
                NSInteger value2=[components day];
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",(int)value2]  forKey:@"day"];
                [[NSUserDefaults standardUserDefaults]synchronize];

                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                    
                }
                else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
               
                {
                 
                }
               
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"No location's found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
        }
        [HUD hide:YES];
    }
    else
    {
        NSLog(@"failure");
    }
    [HUD hide:YES];
    
}
- (void)styleCustomAlertView:(TTAlertView *)alertView
{
    [alertView.containerView setImage:[[UIImage imageNamed:@"alert.bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(11.0f, 13.0f, 14.0f, 13.0f)]];
    [alertView.containerView setBackgroundColor:[UIColor clearColor]];
    
    alertView.buttonInsets = UIEdgeInsetsMake(alertView.buttonInsets.top, alertView.buttonInsets.left + 4.0f, alertView.buttonInsets.bottom + 6.0f, alertView.buttonInsets.right + 4.0f);
}

- (void)addButtonsWithBackgroundImagesToAlertView:(TTAlertView *)alertView
{
    UIImage *redButtonImageOff = [[UIImage imageNamed:@"large.button.red.on.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    UIImage *redButtonImageOn = [[UIImage imageNamed:@"large.button.red.on.png"] stretchableImageWithLeftCapWidth:2.0 topCapHeight:2.0];
    [alertView setButtonBackgroundImage:redButtonImageOff forState:UIControlStateNormal atIndex:0];
    [alertView setButtonBackgroundImage:redButtonImageOn forState:UIControlStateHighlighted atIndex:0];
    
}
-(void)setpin
{
    NSMutableArray *points=[[NSMutableArray alloc]init];
    if ([locationlist count]>0)
    {
        CSMapAnnotation* annotation = nil;
        
        for (int i=0; i<[locationlist count]; i++)
        {
            
            Vehiclelocationlist *list1=[locationlist objectAtIndex:i];
            CLLocationDegrees latitude  = [list1.latitude  doubleValue];
            CLLocationDegrees longitude = [list1.longitude doubleValue];
            
            CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
            [points addObject:currentLocation];
            if([list1.exceed_speed_limit isEqualToString:@"1"])
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypePinkImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"pink_pin.png"];
            }
            else
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeRedImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"red_pin.png"];
            }
           
            
            [mapview addAnnotation:annotation];
            CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
            Pin *newPin = [[Pin alloc]initWithCoordinate:coord];
            [self.allPins addObject:newPin];
            [self drawLines:self];
            
            
        }
        
        Vehiclelocationlist *list1=[locationlist objectAtIndex:[locationlist count]-1];
        CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
        MKCoordinateSpan span = {.latitudeDelta =  0, .longitudeDelta =  0};
        //  MKCoordinateRegion region = {coord, span};
        MKCoordinateRegion region = { .center = coord, .span = span };
        
        
        
        [mapview setRegion:region animated:YES];
        
        
        [points release];
        
        [self.view addSubview:mapview];
        [self.view addSubview:maptype];
        [self.view addSubview:stepper];
        
    }
    
    
}
- (IBAction)drawLines:(id)sender {
    
   
    
    [self drawLineSubroutine];
    [self drawLineSubroutine];
    
}
- (void)drawLineSubroutine {
    
    // remove polyline if one exists
    [self.mapview removeOverlay:self.polyline];
    
    // create an array of coordinates from allPins
    CLLocationCoordinate2D coordinates[self.allPins.count];
    int i = 0;
    for (Pin *currentPin in self.allPins) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
    
    // create a polyline with all cooridnates
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:self.allPins.count];
    [self.mapview addOverlay:polyline];
    self.polyline = polyline;
    
    // create an MKPolylineView and add it to the map view
    self.lineView = [[MKPolylineView alloc]initWithPolyline:self.polyline];
    self.lineView.strokeColor = [UIColor redColor];
    self.lineView.lineWidth = 3;
    
    // for a laugh: how many polylines are we drawing here?
    self.title = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)self.mapview.overlays.count];
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    
    return self.lineView;
}

-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Vehicledetails.php?service=vehiclehistorylist";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&vehicleregno=%@&date=%@&from=%@&to=%@&%@=%@",firstEntity,value1,vehicleregno,selecteddate.text,fromtime.text,totime.text,secondEntity,value2];
   // NSLog(@"post %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
- (IBAction)segmentaction:(id)sender {
    if ([sender selectedSegmentIndex]==0)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"histolive" sender:self];
            
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
             [self performSegueWithIdentifier:@"histolive" sender:self];
            
        }
    }
    if ([sender selectedSegmentIndex]==1)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
           // [self performSegueWithIdentifier:@"livetohis" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
           // [self performSegueWithIdentifier:@"livetohis" sender:self];
            
        }
        
    }
   if (([sender selectedSegmentIndex]==2)&&([[segment titleForSegmentAtIndex:segment.selectedSegmentIndex]isEqualToString:@"Alert Message"]))
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            [self performSegueWithIdentifier:@"histoalert" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"histoalert" sender:self];
            
        }
        
    }
    
    
    if (([sender selectedSegmentIndex]==2)&&([[segment titleForSegmentAtIndex:segment.selectedSegmentIndex]isEqualToString:@"Theft Alarm"]))
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            [self performSegueWithIdentifier:@"histotheft" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"histotheft" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==3)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"histospeed" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"histospeed" sender:self];
            
        }
        
    }


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)logout:(id)sender {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
       [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
         [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}




- (IBAction)home:(id)sender {
    for (id controller in [self.navigationController viewControllers])
    {
        if ([controller isKindOfClass:[WelcomeViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
    
	if([annotation isKindOfClass:[CSMapAnnotation class]])
	{
		// determine the type of annotation, and produce the correct type of annotation view for it.
		CSMapAnnotation* csAnnotation = (CSMapAnnotation*)annotation;
        
        if(csAnnotation.annotationType == CSMapAnnotationTypeRedImage)
		{
			NSString* identifier = @"Red";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
			if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				
			}
			
			annotationView = imageAnnotationView;
		}
        if(csAnnotation.annotationType == CSMapAnnotationTypeGreenImage)
		{
			NSString* identifier = @"Green";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
			if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				
			}
			
			annotationView = imageAnnotationView;
		}
        if(csAnnotation.annotationType == CSMapAnnotationTypePinkImage)
		{
			NSString* identifier = @"Pink";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
			if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				
			}
			
			annotationView = imageAnnotationView;
		}
       
        [annotationView setEnabled:YES];
		[annotationView setCanShowCallout:NO];
		
		
	}
	
	
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	  
    CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*) view;
	CSMapAnnotation* annotation = (CSMapAnnotation*)[imageAnnotationView annotation];
    
	if(annotation.url != nil)
	{
		
	}
    
	
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // NSLog(@"called ");
    CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*) view;
    CSMapAnnotation* annotation = (CSMapAnnotation*)[imageAnnotationView annotation];
    
    CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"calloutView" owner:self options:nil] objectAtIndex:0];
    CGRect calloutViewFrame = calloutView.frame;
    calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
    calloutView.frame = calloutViewFrame;
    [calloutView.calloutLabel setText:[NSString stringWithFormat:@"%@\n%@",[annotation title],[annotation subtitle]]];
    [view addSubview:calloutView];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    for (UIView *subview in view.subviews ){
        UIView* subview1=(UIView*)subview;
        if([subview1 isKindOfClass:[CalloutView class]])
            [subview removeFromSuperview];
    }
}

- (void)viewDidUnload {
	self.mapview   = nil;

}
- (void)dealloc {

    [super dealloc];
    [mapview release];
}
@end
