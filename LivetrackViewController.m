//
//  LivetrackViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "LivetrackViewController.h"
#import "TTAlertView.h"
#import "SBJSON.h"
#import "databaseurl.h"
#import "Vehiclelocationlist.h"
#import "HistorytrackViewController.h"
#import "alertmessageViewController.h"
#import "WelcomeViewController.h"
#import "CSMapAnnotation.h"
#import "CSImageAnnotationView.h"
#define MERCATOR_OFFSET 268435456
#define MERCATOR_RADIUS 85445659.44705395
#define interval 30
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
int i;

@interface LivetrackViewController ()
{
    databaseurl *du;
    int stepper_initial_value;
    CLLocationCoordinate2D _coordinate;
}
@end

@implementation LivetrackViewController
@synthesize mapview;
@synthesize stepper;
@synthesize maptype;
@synthesize imageview;
@synthesize segment;
@synthesize welcome;
@synthesize timer;
@synthesize home;
@synthesize logout;
- (IBAction)maptype:(id)sender {
    if (maptype.selectedSegmentIndex==0) {
        mapview.mapType=MKMapTypeStandard;
    }
    else
    {
        mapview.mapType=MKMapTypeSatellite;
    }
}
- (void)zoomMapinc:(MKMapView*)mapView byDelta:(int) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta*=delta;
    span.longitudeDelta*=delta;
    region.span=span;
    [mapView setRegion:region animated:YES];
    //    CLLocationCoordinate2D centerCoord = { mapview.region.center.latitude,  mapview.region.center.longitude };
    //     MKCoordinateRegion region=[self setCenterCoordinate:centerCoord zoomLevel:delta animated:NO];
//    [mapView setRegion:region animated:YES];
    
}
- (void)zoomMapdec:(MKMapView*)mapView byDelta:(int) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta/=delta;
    span.longitudeDelta/=delta;
    region.span=span;
    [mapView setRegion:region animated:YES];
    //    CLLocationCoordinate2D centerCoord = { mapview.region.center.latitude,  mapview.region.center.longitude };
    //    MKCoordinateRegion region=[self setCenterCoordinate:centerCoord zoomLevel:delta animated:NO];
//    [mapView setRegion:region animated:YES];
    
    
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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)segmentaction:(id)sender {
    if ([sender selectedSegmentIndex]==0)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
           // [self performSegueWithIdentifier:@"livetolive" sender:self];
           
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            //  [self performSegueWithIdentifier:@"livetolive" sender:self];
            
        }
    }
    if ([sender selectedSegmentIndex]==1)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
              [self performSegueWithIdentifier:@"livetohis" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
              [self performSegueWithIdentifier:@"livetohis" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==2)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
              [self performSegueWithIdentifier:@"livetoalert" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
             [self performSegueWithIdentifier:@"livetoalert" sender:self];
            
        }
        
    }
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
-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Vehicledetails.php?service=vehiclelivelist";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&vehicleregno=%@&%@=%@",firstEntity,value1,vehicleregno,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    i=1;
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == welcome && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 102;
            }
            if (con.firstItem == home && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 74;
            }
            if (con.firstItem == logout && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 106;
            }
            if (con.firstItem == segment && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =135;
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
        
    }
    else  if (([role isEqualToString:@"ROLE_PCLIENT"]) ||   ([role isEqualToString:@"ROLE_FCLIENT"]))
    {
        [segment removeSegmentAtIndex:2 animated:YES];
    }
     locationlist=[[NSMutableArray alloc]init];
    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
    mapview.delegate=self;
    du=[[databaseurl alloc]init];
 
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Times New Roman" size:20], UITextAttributeFont,nil];
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont fontWithName:@"Times New Roman" size:15], UITextAttributeFont,nil];
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
        
    }
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
    
    
    NSString *filename = [du imagecheck:@"livetrack.png"];
    NSLog(@"image name %@",filename);
    
    mapview.delegate=self;
    
    imageview.image = [UIImage imageNamed:filename];
    if (!timer) {
        NSLog(@"timer start");
        timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(getData)
                                               userInfo:nil
                                                repeats:YES];
    }
    [self getData];
    
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
       
        
        if (parsedvalue == nil)
        {
            
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            NSArray *datas=[menu objectForKey:@"vehiclelive List"];
            
            
            //     To check whether its having data or not
            //              NSLog(@"datas %lu",(unsigned long)[datas count]);
            
            if ([datas count]>0)
            {
                int i=0;
                
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
                 //   NSLog(@"list 1 %@",list1);
                    //Check if data already available in array
                    if ([locationlist count]>0)
                    {
                        int present=0;
                        for (int j=0; j<[locationlist count]; j++)
                        {
                            Vehiclelocationlist *list2=[locationlist objectAtIndex:j];
                            if (([list1.latitude isEqualToString:list2.latitude])&&([list1.longitude isEqualToString:list2.longitude])) {
                                NSLog(@"datas available in array");
                                present=1;
                                break;
                            }
                            else
                            {
                               present=0;
                            }
                        }
                        if (present==1)
                        {
                             NSLog(@"datas available in array verified");
                        }
                        
                        else
                        {
                                NSLog(@"datas not in array");
                                if (i==0)
                                {
                                    NSLog(@"add new data in first location");
                                    [locationlist insertObject:list1 atIndex:0];
                                  //  NSLog(@"lovationlist 1 %@",locationlist[0]);
                                    
                                    
                                    
                                }
                                else
                                {
                                    NSLog(@"add in array");
                                    [locationlist addObject:list1];
                                   
//                                      NSLog(@"lovationlist 1 %@",locationlist[0]);
//                                      NSLog(@"lovationlist 1 %@",[locationlist lastObject]);
//                                    
                                }
                            }
                        
                    }
                    else
                    {
                    
                        [locationlist addObject:list1];
                    
                    }
                    i++;
                    
                }
                [self setpin];
                
            }
            else
            {
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"No location's found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
        }
        
    }
    else
    {
        NSLog(@"failure");
    }
    
}
-(void)setpin
{
    
     NSMutableArray *points=[[NSMutableArray alloc]init];
    MKMapRect visibleMapRect = mapview.visibleMapRect;
    NSLog(@"visible");
    NSSet *visibleAnnotations = [mapview annotationsInMapRect:visibleMapRect];
      NSLog(@"visible1");
    if ([visibleAnnotations count]>0)
    {
          NSLog(@"visible3");
        //check annotations present in map if >0 remove everything
        [self.mapview removeAnnotations:self.mapview.annotations];
    }
    
  
    if ([locationlist count]>0)
    {
        CSMapAnnotation* annotation = nil;
        for (int i=0; i<[locationlist count]; i++)
        {
            CLLocationManager *manager=[[CLLocationManager alloc]init];
            manager.delegate=self;
            Vehiclelocationlist *list1=[locationlist objectAtIndex:i];
            CLLocationDegrees latitude  = [list1.latitude  doubleValue];
            CLLocationDegrees longitude = [list1.longitude doubleValue];
            CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
            [points addObject:currentLocation];
            if ((i==0)&&([list1.exceed_speed_limit isEqualToString:@"0"])) {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeGreenImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr",list1.speed]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                 [annotation setUserData:@"green_pin.png"];
            }
            else if (((i==0)&&([list1.exceed_speed_limit isEqualToString:@"1"]))||([list1.exceed_speed_limit isEqualToString:@"1"]))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypePinkImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr",list1.speed]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"pink_pin.png"];
            }
            else
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeRedImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr",list1.speed]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                 [annotation setUserData:@"red_pin.png"];
            }
            if ((i==0)&&([list1.exceed_speed_limit isEqualToString:@"0"])) {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeGreenImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr",list1.speed]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                 [annotation setUserData:@"green_pin.png"];
            }
            
          [mapview addAnnotation:annotation];
            
        }
         Vehiclelocationlist *list1=[locationlist objectAtIndex:0];
        CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
        MKCoordinateSpan span = {.latitudeDelta =  18.0, .longitudeDelta =  18.0};
        //  MKCoordinateRegion region = {coord, span};
        MKCoordinateRegion region = { .center = coord, .span = span };
        
        
        
        [mapview setRegion:region animated:YES];
       
       
        [self.view addSubview:mapview];
        [self.view addSubview:maptype];
        [self.view addSubview:stepper];
        
    }
    
    
}
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    
//      _coordinate.latitude = userLocation.location.coordinate.latitude;
//      _coordinate.longitude = userLocation.location.coordinate.longitude;
//    
//    [self setMapRegionWithCoordinate:_coordinate];
//}
//
//- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    MKCoordinateRegion region;
//    
//    region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(.1, .1));
//    MKCoordinateRegion adjustedRegion = [mapview regionThatFits:region];
//    [mapview setRegion:adjustedRegion animated:YES];
//}

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
#pragma mark mapView delegate functions

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView* annotationView = nil;
	
    
	if([annotation isKindOfClass:[CSMapAnnotation class]])
	{
		// determine the type of annotation, and produce the correct type of annotation view for it.
		CSMapAnnotation* csAnnotation = (CSMapAnnotation*)annotation;
//		if(csAnnotation.annotationType == CSMapAnnotationTypeStart ||
//		   csAnnotation.annotationType == CSMapAnnotationTypeEnd)
//		{
//			NSString* identifier = @"Pin";
//			MKPinAnnotationView* pin = (MKPinAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
//			
//			if(nil == pin)
//			{
//				pin = [[[MKPinAnnotationView alloc] initWithAnnotation:csAnnotation reuseIdentifier:identifier] autorelease];
//			}
//            
			
//			[pin setPinColor:(csAnnotation.annotationType == CSMapAnnotationTypeEnd) ? MKPinAnnotationColorRed : MKPinAnnotationColorGreen];
//			///NSLog(@"pav.frame.size = %@, pav.image.size = %@",  NSStringFromCGSize(pin.frame.size),                 NSStringFromCGSize(pin.image.size));
//			annotationView = pin;
//		}
         if(csAnnotation.annotationType == CSMapAnnotationTypeRedImage)
		{
			NSString* identifier = @"Red";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
			if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				//imageAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
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
				//imageAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
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
				//imageAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			}
			
			annotationView = imageAnnotationView;
		}
	//	annotationView.centerOffset=CGPointMake(100,100);
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:YES];
		
		
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

#pragma mark -
#pragma mark Map conversion methods

- (double)longitudeToPixelSpaceX:(double)longitude
{
    return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)latitudeToPixelSpaceY:(double)latitude
{
    return round(MERCATOR_OFFSET - MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (MKCoordinateRegion)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                zoomLevel:(NSUInteger)zoomLevel
                                 animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self coordinateSpanWithMapView:self.mapview centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    return region;
}


-(void)viewWillDisappear:(BOOL)animated
{
    if ([timer isValid]) {
//        NSLog(@"timer stopped in will disappeae");
        [timer invalidate];
    }
}
- (void)dealloc {
    
    
   
//    if ([timer isValid]) {
//        NSLog(@"timer stopped in dealloc");
//        [timer invalidate];
//    }
    [super dealloc];
    [mapview release];
 
 
}
@end
