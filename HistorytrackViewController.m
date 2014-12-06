//
//  HistorytrackViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "HistorytrackViewController.h"
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

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

@synthesize stepper;
@synthesize maptype;

@synthesize mapview;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - Zooming  MapView
- (void)zoomMapinc:(MKMapView*)mapView byDelta:(float) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta*=delta;
    span.longitudeDelta*=delta;
    region.span=span;
    CLLocationCoordinate2D coord = {.latitude =  region.center.latitude , .longitude =region.center.longitude};
    if (!CLLocationCoordinate2DIsValid(coord))
    {
        NSLog(@"userlocation coordinate is invalid");
        return;
    }
    else
        [mapView setRegion:region animated:YES];
    
}
- (void)zoomMapdec:(MKMapView*)mapView byDelta:(float) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta/=delta;
    span.longitudeDelta/=delta;
    region.span=span;
    CLLocationCoordinate2D coord = {.latitude =  region.center.latitude , .longitude =region.center.longitude};
    if (!CLLocationCoordinate2DIsValid(coord))
    {
        NSLog(@"userlocation coordinate is invalid");
        return;
    }
    else
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
#pragma mark - YLMenuItemActions
- (void)toolButtonTapped:(id)sender {
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[SearchMenu class]]) {
            [view removeFromSuperview];
        }
    }
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[YLMenuItem menuItemWithTitle:@"Live Track"
                                              icon:[UIImage imageNamed:@"liveicon.png"]
                                       pressedIcon:[UIImage imageNamed:@"liveicon.png"]
                                          selector:@selector(LiveTapped)]];
    [items addObject:[YLMenuItem menuItemWithTitle:@"History Track"
                                              icon:[UIImage imageNamed:@"historyicon.png"]
                                       pressedIcon:[UIImage imageNamed:@"historyicon.png"]
                                          selector:@selector(HistoryTapped)]];
	
    NSString *role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    
	
    if ([role isEqualToString:@"ROLE_ADMIN"])
    {
        
        [items addObject:[YLMenuItem menuItemWithTitle:@"Alert Message"
                                                  icon:[UIImage imageNamed:@"home.png"]
                                           pressedIcon:[UIImage imageNamed:@"home.png"]
                                              selector:@selector(alertTapped)]];
        
    }
    else  if (([role isEqualToString:@"ROLE_PCLIENT"]) ||   ([role isEqualToString:@"ROLE_FCLIENT"]))
    {
        [items addObject:[YLMenuItem menuItemWithTitle:@"Theft Alarm"
                                                  icon:[UIImage imageNamed:@"alarmicon.png"]
                                           pressedIcon:[UIImage imageNamed:@"alarmicon.png"]
                                              selector:@selector(TheftTapped)]];
        [items addObject:[YLMenuItem menuItemWithTitle:@"Over Speed"
                                                  icon:[UIImage imageNamed:@"overspeedicon.png"]
                                           pressedIcon:[UIImage imageNamed:@"overspeedicon.png"]
                                              selector:@selector(OverspeedTapped)]];
        
    }
    YLPopoverMenu* menu = [YLPopoverMenu popoverMenuWithItems:items target:self];
    [menu presentPopoverFromBarButtonItem:button animated:YES];
}
- (void)LiveTapped {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"histolive" sender:self];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"histolive" sender:self];
        
    }
    
    
}

- (void)HistoryTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        // [self performSegueWithIdentifier:@"thefttohis" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        //
        // [self performSegueWithIdentifier:@"thefttohis" sender:self];
        
    }
}

- (void)TheftTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self performSegueWithIdentifier:@"histotheft" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"histotheft" sender:self];
        
    }
    
}
- (void)OverspeedTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"histospeed" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"histospeed" sender:self];
        
    }
}
- (void)alertTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self performSegueWithIdentifier:@"histoalert" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"histoalert" sender:self];
        
    }
    
}
-(void)Search_Action:(id)sender
{
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[SearchMenu class]]) {
            [view removeFromSuperview];
        }
    }
    if (IS_IPAD) {
       
        SearchMenu * vc=[[SearchMenu alloc]initWithFrame:CGRectMake(0,0,768,1024)];
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HistorySearchDone" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(Historysearch:) name:@"HistorySearchDone"object:nil];
        
    }
    else
    {
        
   SearchMenu * vc=[[SearchMenu alloc]initWithFrame:CGRectMake(0,0,320,568)]; //Initialize this way otherwise you cannt access controllers from view.
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"HistorySearchDone" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(Historysearch:) name:@"HistorySearchDone"object:nil];
        
    }
}
- (void)infoViewTappedHistory {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        
         HistroytrackInformation * vc=[[HistroytrackInformation alloc]initWithFrame:CGRectMake(0,0,768,1024)];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        
   HistroytrackInformation * vc=[[HistroytrackInformation alloc]initWithFrame:CGRectMake(0,0,320,568)]; //Initialize this way otherwise you cannt access controllers from view.
        
    }
}

#pragma mark - DidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.topViewController.title=@"Tracking History";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIButton* back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UIBarButtonItem *button11 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = button11;
    
    
    
    
    UIButton* searchButton;
    UIButton* infoButton;
  
   
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        searchButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [searchButton setImage:[UIImage imageNamed:@"Search_Icon.png"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(Search_Action:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
        
        infoButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [infoButton setImage:[UIImage imageNamed:@"Info_Icon.png"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(infoViewTappedHistory) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
      
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width =-14;
        
        [self.navigationItem setLeftBarButtonItems:@[fixedItem1,infoBarButton,fixedItem1,searchBarButton,fixedItem1]];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        searchButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
        [searchButton setImage:[UIImage imageNamed:@"Search_Icon.png"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(Search_Action:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
        
         infoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        [infoButton setImage:[UIImage imageNamed:@"Info_Icon.png"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(infoViewTappedHistory) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 20;
        
        [self.navigationItem setLeftBarButtonItems:@[infoBarButton,fixedItem1,searchBarButton,fixedItem1]];
    }
    
    
    //Right BAr Button Items...
    
    UIButton* homeButton;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Icon.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolButtonTapped:)];
       
        homeButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [homeButton setImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
        [homeButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homebutton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = -12;
        UIBarButtonItem *fixedItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem2.width = -14;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem2,b]];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Test.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolButtonTapped:)];
//        [b setBackgroundImage:[UIImage imageNamed:@"Menu_ipad.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [b setImageInsets:UIEdgeInsetsMake(0, 5, 0, -10)];
        homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
        [homeButton setImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
        [homeButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homebutton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 20;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem1,b]];
    }
    
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
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
    
    //Reintialize totalDistance Value
    [[NSUserDefaults standardUserDefaults]setValue:@""  forKey:@"TotalDistance"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.allPins = [[NSMutableArray alloc]init];
    
    
    CLLocationCoordinate2D coord = {.latitude =  22.3512639, .longitude =78.9542827};
    MKCoordinateSpan span = {.latitudeDelta =  30, .longitudeDelta =  30};
    //  MKCoordinateRegion region = {coord, span};
    MKCoordinateRegion region = { .center = coord, .span = span };
    
    
    
    [mapview setRegion:region animated:YES];
  
    
    stepper_initial_value=stepper.value;
  
    du=[[databaseurl alloc]init];
   
    
    mapview.delegate=self;
    
    
    
    
}




#pragma mark - search Action
- (IBAction)Historysearch:(id)sender {
   
//    NSLog(@"Object received %@",[sender valueForKey:@"object"]);   
    self.SelectedDate= [[sender valueForKey:@"object"] valueForKey:@"Selected_Date"];
    self.FromTime =[[sender valueForKey:@"object"] valueForKey:@"Selected_Fromtime"];
      self.ToTime =[[sender valueForKey:@"object"] valueForKey:@"Selected_Totime"];
    
        if ([self.SelectedDate length]>0)
        {
            HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            HUD.mode=MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Please wait";
            [HUD show:YES];
            [self performSelector:@selector(getData) withObject:self afterDelay:0.1f];
        }
        else
        {
            NSLog(@"Date Null");
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
                         NSLog(@"datas %lu",(unsigned long)[datas count]);
            
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
#pragma mark - CustomPicker
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
#pragma mark - DrawPin with Lat nd Long
-(void)setpin
{
   
    NSMutableArray *points=[[NSMutableArray alloc]init];
    self.allPins = [[NSMutableArray alloc]init];
    MKMapRect visibleMapRect = mapview.visibleMapRect;
    //    NSLog(@"visible");
    NSSet *visibleAnnotations = [mapview annotationsInMapRect:visibleMapRect];
    //    NSLog(@"visible1");
    if ([visibleAnnotations count]>0)
    {
        //        NSLog(@"visible3");
        //check annotations present in map if >0 remove everything
        [self.mapview removeAnnotations:self.mapview.annotations];
    }
    
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
             if ((i==[locationlist count]-1)||(i==0))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeStartAndStopImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"start.png"];
                
            }
           else if([list1.exceed_speed_limit isEqualToString:@"1"])
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypePinkImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"pink.png"];
            }
           
            else
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeRedImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"red.png"];
            }
            if ((i==[locationlist count]-1)||(i==0))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:i] coordinate]
                                                           annotationType:CSMapAnnotationTypeStartAndStopImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"start.png"];
                
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
        [self Distance];
    
    }
     self.navigationController.topViewController.title=@"Tracking History";

}
#pragma mark -Calculate Distance
-(void)Distance
{
    double total=0;
     distanceValues=[[NSMutableArray alloc]init];
    for (int i=0; i<[locationlist count]-1; i++)
    {
        int j=i+1;
        
            Vehiclelocationlist *list1=[locationlist objectAtIndex:i];
//            CLLocationDegrees latitude1  = [list1.latitude  doubleValue];
//            CLLocationDegrees longitude1 = [list1.longitude doubleValue];
//              NSLog(@"Latitude %d %@",i,list1);
            Vehiclelocationlist *list2=[locationlist objectAtIndex:j];
//            CLLocationDegrees latitude2  = [list2.latitude  doubleValue];
//            CLLocationDegrees longitude2 = [list2.longitude doubleValue];
//            NSLog(@"Latitude %d %@",j,list2);
//            CLLocation *startLoc = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longitude1];
//            CLLocation *destLoc = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
//            CLLocationDistance meters = [destLoc distanceFromLocation:startLoc]/1000;
//            NSLog(@"Distance in meters %f",meters);
//            [distanceValues addObject:[NSNumber numberWithDouble:meters]];
        [distanceValues addObject:[NSNumber numberWithDouble:[self DistanceByLatLong:[list1.latitude  doubleValue] lat2:[list2.latitude  doubleValue] log1:[list1.longitude doubleValue] log2:[list2.longitude doubleValue]]]];
        
    }
    
    for (int i=0; i<[distanceValues count]; i++)
    {
        total+=[[distanceValues objectAtIndex:i] doubleValue];
    }
    NSLog(@"Total Value %f",total);
      [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%f",total]  forKey:@"TotalDistance"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(double) Deg2Rad:(double) degrees
{
    return degrees == 0 ? degrees : (degrees * M_PI / 180.0);
}
-(double)DistanceByLatLong:(double)lat1 lat2:(double)lat2 log1:(double)log1 log2:(double)log2
{
     int R = 6371; // Radius of the earth
    double latDistance = [self Deg2Rad:lat2 - lat1];
    double lonDistance = [self Deg2Rad:log2 - log1];
    double a = sin(latDistance / 2) * sin(latDistance / 2)
    + cos([self Deg2Rad: lat1]) * cos([self Deg2Rad:lat2])
    * sin(lonDistance / 2) * sin(lonDistance / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = R * c; // convert the meters
    return distance;
    
}
#pragma mark - Draw PolyLine
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
        if(csAnnotation.annotationType == CSMapAnnotationTypeStartAndStopImage)
		{
			NSString* identifier = @"StartAndStop";
			
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
    
  
    
    if (IS_IPAD) {
        CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"calloutView" owner:self options:nil] objectAtIndex:1];
        CGRect calloutViewFrame = calloutView.frame;
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
        calloutViewFrame.size=CGSizeMake(300, 100);
        calloutView.frame = calloutViewFrame;
        [calloutView.calloutLabel setText:[NSString stringWithFormat:@"%@\n%@",[annotation title],[annotation subtitle]]];
        [view addSubview:calloutView];
    }
    else
    {
        CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"calloutView" owner:self options:nil] objectAtIndex:0];
        CGRect calloutViewFrame = calloutView.frame;
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 15, -calloutViewFrame.size.height);
        calloutView.frame = calloutViewFrame;
        [calloutView.calloutLabel setText:[NSString stringWithFormat:@"%@\n%@",[annotation title],[annotation subtitle]]];
        [view addSubview:calloutView];
    }
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    for (UIView *subview in view.subviews ){
        UIView* subview1=(UIView*)subview;
        if([subview1 isKindOfClass:[CalloutView class]])
            [subview removeFromSuperview];
    }
}
#pragma mark - Http Method to getList
-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Vehicledetails.php?service=vehiclehistorylist";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&vehicleregno=%@&date=%@&from=%@&to=%@&%@=%@",firstEntity,value1,vehicleregno,self.SelectedDate,self.FromTime,self.ToTime,secondEntity,value2];
    // NSLog(@"post %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)home:(id)sender {
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[SearchMenu class]]) {
            [view removeFromSuperview];
        }
    }
    for (id controller in [self.navigationController viewControllers])
    {
        if ([controller isKindOfClass:[WelcomeViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
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
