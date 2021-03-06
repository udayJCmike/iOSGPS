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


@interface LivetrackViewController ()
{
    databaseurl *du;
    int stepper_initial_value;
    CLLocationCoordinate2D _coordinate;
    InformationVC *vc;
}
@property (nonatomic, strong) NSMutableArray *allPins;
@property (nonatomic, strong) MKPolylineView *lineView;
@property (nonatomic, strong) MKPolyline *polyline;

- (IBAction)drawLines:(id)sender;
@end

@implementation LivetrackViewController
@synthesize mapview;
@synthesize stepper;
@synthesize maptype;
@synthesize valuesArray;
@synthesize colorsArray;
@synthesize randomcolorsArray;

@synthesize timer;

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
      CLLocationCoordinate2D coord = {.latitude =  region.center.latitude , .longitude =region.center.longitude};
    if (!CLLocationCoordinate2DIsValid(coord))
    {
//        NSLog(@"userlocation coordinate is invalid");
        return;
    }
    else
        [mapView setRegion:region animated:YES];
        
    
    
    
}
- (void)zoomMapdec:(MKMapView*)mapView byDelta:(int) delta {
    
    MKCoordinateRegion region = mapView.region;
    MKCoordinateSpan span = mapView.region.span;
    span.latitudeDelta/=delta;
    span.longitudeDelta/=delta;
    region.span=span;
    CLLocationCoordinate2D coord = {.latitude =  region.center.latitude , .longitude =region.center.longitude};
    if (!CLLocationCoordinate2DIsValid(coord))
    {
//        NSLog(@"userlocation coordinate is invalid");
        return;
    }
    else
        [mapView setRegion:region animated:YES];
    
    
    
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

- (void)toolButtonTapped:(id)sender {
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
        // [self performSegueWithIdentifier:@"livetolive" sender:self];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        //  [self performSegueWithIdentifier:@"livetolive" sender:self];
        
    }
    
    
    
    
}

- (void)HistoryTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"livetohis" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"livetohis" sender:self];
        
    }
}

- (void)TheftTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self performSegueWithIdentifier:@"livetotheft" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"livetotheft" sender:self];
        
    }
}
- (void)OverspeedTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"livetospeed" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"livetospeed" sender:self];
        
    }
}
- (void)alertTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self performSegueWithIdentifier:@"livetoalert" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"livetoalert" sender:self];
        
    }
}
- (void)infoViewTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        
        UIViewController *initialvc=[self.storyboard instantiateViewControllerWithIdentifier:@"InformationPageForLive"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initialvc];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        
        vc=[[InformationVC alloc]initWithFrame:CGRectMake(0,0,320,568)]; //Initialize this way otherwise you cannt access controllers from view.
        
    }
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)UpdateCountDown:(NSTimer*)theTimer
{
    
    if (TotalSec>1) {
        TotalSec--;
    }
    else if(TotalSec==1)
    {
        TotalSec=30;
      
         [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"StartDate"];
          [[NSUserDefaults standardUserDefaults]synchronize];
    }
    //  NSLog(@"Tick time %d and timeinterval %@ startDate %@",TotalSec, [theTimer fireDate],[CountDownTimer userInfo]);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",TotalSec] forKey:@"tickcount"];
    [[NSUserDefaults standardUserDefaults] setObject:[theTimer fireDate] forKey:@"ticktime"];
   
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)viewWillDisappear:(BOOL)animated
{
//    NSLog(@"Disappear called");
    
    if ([timer isValid]) {
        //        NSLog(@"timer stopped in will disappeae");
        [timer invalidate];
    }
    if ([CountDownTimer isValid]) {
        //        NSLog(@"timer stopped in will disappeae");
        TotalSec=0;
        [CountDownTimer invalidate];
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
    
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
    
    
    
    //Right BAr Button Items...
    
    
    // self.navigationItem.rightBarButtonItem = b;
    
    UIButton* homeButton;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        
        UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Icon.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolButtonTapped:)];
        //        UIImage *imgBack = [UIImage imageNamed:@"Menu_iphone.png"];
        //        [b setBackgroundImage:imgBack forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        homeButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [homeButton setImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
        [homeButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homebutton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 10;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem1,b]];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Test.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolButtonTapped:)];
        //  UIImage *imgBack = [UIImage imageNamed:@"Menu_ipad.png"];
        //  [b setBackgroundImage:imgBack forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
        [homeButton setImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
        [homeButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homebutton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 20;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem1,b]];
    }
    
    
    
    //Left Bar Button Items..
    UIButton* infoButton;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        infoButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        infoButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    }
    
    [infoButton setImage:[UIImage imageNamed:@"Info_Icon.png"] forState:UIControlStateNormal];
    [infoButton addTarget:self action:@selector(infoViewTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 10;
    
    [self.navigationItem setLeftBarButtonItems:@[fixedItem,button1,fixedItem]];
    
    
    
    randomcolorsArray=[[NSArray alloc]initWithObjects:@"redColor",@"brownColor",@"cyanColor" ,@"yellowColor",@"magentaColor",@"purpleColor",@"blueColor",@"darkGrayColor",nil];
    self.currentLineColor=@"redColor";
    
    locationlist=[[NSMutableArray alloc]init];
    valuesArray=[[NSMutableArray alloc]init];
    colorsArray=[[NSMutableArray alloc]init];
    [colorsArray addObject:@"redColor"];
    [valuesArray addObject:@"0"];
    mapview.delegate=self;
    du=[[databaseurl alloc]init];
    
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
    CLLocationCoordinate2D coord = {.latitude =  22.3512639, .longitude =78.9542827};
    MKCoordinateSpan span = {.latitudeDelta =  30, .longitudeDelta =  30};
    //  MKCoordinateRegion region = {coord, span};
    MKCoordinateRegion region = { .center = coord, .span = span };
    
    
    
    [mapview setRegion:region animated:YES];
    
    mapview.delegate=self;
    [self performSelector:@selector(getData) withObject:self afterDelay:0.1f];
    if (!timer) {
        //  NSLog(@"timer start");
        timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(getData)
                                               userInfo:nil
                                                repeats:YES];
    }
    if (!CountDownTimer) {
        //  NSLog(@"timer start");
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setValue:[NSDate date] forKey:@"StartDate"];
        CountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(UpdateCountDown:)
                                                        userInfo:dict
                                                         repeats:YES];
         [[NSUserDefaults standardUserDefaults] setObject:[[CountDownTimer userInfo] objectForKey:@"StartDate"] forKey:@"StartDate"];
        TotalSec=30;
    }
    
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
    
//    NSLog(@" title %@",self.navigationController.navigationItem.title);
}
#pragma mark-GetRandomColor
-(void)UpdateLineColor
{
    int index= arc4random()%8;
    if ([self.currentLineColor isEqual:[randomcolorsArray objectAtIndex:index]]) {
        [self UpdateLineColor];
    }
    else
    {
        self.currentLineColor=[randomcolorsArray objectAtIndex:index];
    }
    
    
}
#pragma mark-CheckDataAvailability
- (void)CheckIndex:(int)fromIndex
{
    
    if ([valuesArray containsObject:[NSNumber numberWithInt:fromIndex]]) {
        self.currentLineColor=  [colorsArray objectAtIndex:[valuesArray indexOfObject:[NSNumber numberWithInt:fromIndex]]];
        
    }
    else
    {
        [self UpdateLineColor];
        [valuesArray addObject:[NSNumber numberWithInt:fromIndex]];
        [colorsArray addObject:self.currentLineColor];
    }
    
}
#pragma mark-Download JSON Values
-(void)getData
{
    
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        
        NSString *orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
        
        NSString *response=[self HttpPostEntityFirst1:@"orgid" ForValue1:orgid   EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
//        NSLog(@"parsedvalue %@",parsedvalue);
        
        if (parsedvalue == nil)
        {
            
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            NSArray *datas=[menu objectForKey:@"vehiclelive List"];
            //DataCount=0 ,If device is not in active mode
            //DataCount=1 ,If device is  in active mode
            if ([[menu objectForKey:@"DataCount"]isEqualToString:@"0"])
            {
                
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
                        list1.devicestatus=[arrayList1 objectForKey:@"devicestatus"];
                        list1.Latest=NO;
                        if ([locationlist count]>0)
                        {
                            
                            int present=0;
                            
                            
                            Vehiclelocationlist *list2=[locationlist lastObject];
                            if (([list1.latitude isEqualToString:list2.latitude])&&([list1.longitude isEqualToString:list2.longitude]))
                            {
                                if (![list2.devicestatus isEqualToString:@"3"]) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                  
                                }
                                else if (([list1.devicestatus isEqualToString:@"3"])&&([list2.devicestatus isEqualToString:@"3"])) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                   
                                }
                                else if ((![list1.devicestatus isEqualToString:@"3"])&&([list2.devicestatus isEqualToString:@"3"])) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                    
                                }
                                else
                                {
                                    present=0;
                                }
                                
                            }
                            else
                            {
                                present=0;
                            }
                            
                            if (present==1)
                            {
//                                NSLog(@"datas available and replaced with updated value");
                                
                                [locationlist replaceObjectAtIndex:[locationlist count]-1 withObject:list1];  //Replaced existing not responding location with latest one at n th index
                                
                                
                            }
                            
                            else
                            {
//                                NSLog(@"datas not in array");
                                
                                [locationlist addObject:list1];  ///Locationlist contains values in Desc order(latest value will be present at n th index)
                                
                                
                            }
                            
                        }
                        else
                        {
                            
                            [locationlist addObject:list1];
                            
                        }
                        
                        
                    }
                    [self setpin];
                    
                }
                
                
            }
            else
            {
                
                
                
                
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
                        list1.devicestatus=[arrayList1 objectForKey:@"devicestatus"];
                        list1.flag=[arrayList1 objectForKey:@"flag"];
                        list1.Latest=YES;
                        //Check if data already available in array
                        if ([locationlist count]>0)
                        {
                            int present=0;
                            
                            Vehiclelocationlist *list2=[locationlist lastObject];
                            if (([list1.latitude isEqualToString:list2.latitude])&&([list1.longitude isEqualToString:list2.longitude]))
                            {
                                if (![list2.devicestatus isEqualToString:@"3"]) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                    
                                }
                                else if (([list1.devicestatus isEqualToString:@"3"])&&([list2.devicestatus isEqualToString:@"3"])) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                    
                                }
                                else if ((![list1.devicestatus isEqualToString:@"3"])&&([list2.devicestatus isEqualToString:@"3"])) {
//                                    NSLog(@"datas available in array");
                                    present=1;
                                    
                                }
                                else
                                {
                                    present=0;
                                }
                            }
                            else
                            {
                                present=0;
                            }
                            
                            if (present==1)
                            {
//                                NSLog(@"datas available and replaced with updated value");
                                [locationlist replaceObjectAtIndex:[locationlist count]-1 withObject:list1];
                            }
                            
                            else
                            {
                                
//                                NSLog(@"add new");
                                [locationlist addObject:list1];  ///Locationlist contains values in asc order(latest value will be present at n th index)
                                //  NSLog(@"lovationlist 1 %@",locationlist[0]);
                                
                            }
                            
                            
                        }
                        else
                        {
                            
                            [locationlist addObject:list1];
                            
                        }
                      
                        
                    }
                    [self setpin];
                    
                }
                else
                {
                    // NSLog(@"alert");
                    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"No location's found." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [self styleCustomAlertView:alertView];
                    [self addButtonsWithBackgroundImagesToAlertView:alertView];
                    [alertView show];
                    [self performSelector:@selector(dismissalert:) withObject:alertView afterDelay:15.0];
                }
            }//DataCount=1
        }
        
    }
    else
    {
        // NSLog(@"failure");
    }
    
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
}
-(void)dismissalert:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark-DrawPIN
-(void)setpin
{
    
    NSMutableArray *points=[[NSMutableArray alloc]init];
    self.allPins = [[NSMutableArray alloc]init];
    MKMapRect visibleMapRect = mapview.visibleMapRect;
    //    NSLog(@"visible");
    NSSet *visibleAnnotations = [mapview annotationsInMapRect:visibleMapRect];
    //      NSLog(@"visible1");
    if ([visibleAnnotations count]>0)
    {
        //          NSLog(@"visible3");
        //check annotations present in map if >0 remove everything
        [self.mapview removeAnnotations:self.mapview.annotations];
        [self.mapview removeOverlays:[self.mapview overlays]];
    }
//    
//    NSLog(@"Locationlist");
    if ([locationlist count]>0)
    {
        CSMapAnnotation* annotation = nil;
        for (int k=0; k<[locationlist count]; k++)
        {
            CLLocationManager *manager=[[CLLocationManager alloc]init];
            manager.delegate=self;
            Vehiclelocationlist *list1=[locationlist objectAtIndex:k];
            
            CLLocationDegrees latitude  = [list1.latitude  doubleValue];
            CLLocationDegrees longitude = [list1.longitude doubleValue];
            CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
            [points addObject:currentLocation];
            
            if ((!list1.Latest)&&(![list1.devicestatus isEqualToString:@"3"]))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeNotRespondingImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"black.png"];
                NSLog(@"location %d lat %@ long %@ annotation type Not responing in datacount =0",k,list1.latitude ,list1.longitude);
            }
            else if ((!list1.Latest)&&([list1.devicestatus isEqualToString:@"3"]))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeSleepModeImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"orange.png"];
                NSLog(@"location %d lat %@ long %@ annotation type orange",k,list1.latitude ,list1.longitude);
                [self CheckIndex:k];
            }
            else if ((list1.Latest)&&([list1.devicestatus isEqualToString:@"3"]))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeSleepModeImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"orange.png"];
                NSLog(@"location %d lat %@ long %@ annotation type orange",k,list1.latitude ,list1.longitude);
                [self CheckIndex:k];
            }
           
            else if ((k==[locationlist count]-1)&&([list1.exceed_speed_limit isEqualToString:@"0"])&&([list1.devicestatus isEqualToString:@"1"])) {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeGreenImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                
                [annotation setUserData:@"green.png"];
                NSLog(@"location %d lat %@ long %@ annotation type green",k,list1.latitude ,list1.longitude);
            }
            
            else if (((k==[locationlist count]-1)&&([list1.exceed_speed_limit isEqualToString:@"1"])&&([list1.devicestatus isEqualToString:@"1"]))||(([list1.exceed_speed_limit isEqualToString:@"1"]&&([list1.devicestatus isEqualToString:@"1"]))))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypePinkImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"pink.png"];
                NSLog(@"location %d lat %@ long %@ annotation type pink",k,list1.latitude ,list1.longitude);
            }
            else if ((list1.Latest)&&(([list1.devicestatus isEqualToString:@"0"])||([list1.devicestatus isEqualToString:@"2"])))
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeNotRespondingImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"black.png"];
                NSLog(@"location %d lat %@ long %@ annotation type Not responing datacount =1",k,list1.latitude ,list1.longitude);
            }
            
            else
                
            {
                annotation = [[[CSMapAnnotation alloc] initWithCoordinate:[[points objectAtIndex:k] coordinate]
                                                           annotationType:CSMapAnnotationTypeRedImage
                                                                    title:[NSString stringWithFormat:@"Speed:%@ km/hr Date:%@",list1.speed,list1.bus_tracking_timestamp]subtitle: [NSString stringWithFormat:@"Address:%@",list1.address]] autorelease];
                [annotation setUserData:@"red.png"];
                NSLog(@"location %d lat %@ long %@ annotation type red",k,list1.latitude ,list1.longitude);
            }
            
            
            [mapview addAnnotation:annotation];
            
            
            
        }
        [self DrawPolyLine];
        
        Vehiclelocationlist *list1=[locationlist objectAtIndex:[locationlist count]-1];
        CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
        MKCoordinateSpan span = {.latitudeDelta =  0.00, .longitudeDelta =  0.00};
        //  MKCoordinateRegion region = {coord, span};
        MKCoordinateRegion region = { .center = coord, .span = span };
        
        
        
        [mapview setRegion:region animated:YES];
        
        [points release];
        
        [self.view addSubview:mapview];
        [self.view addSubview:maptype];
        [self.view addSubview:stepper];
        
        
    }
    
    self.navigationController.topViewController.title=@"Live Track";
    self.navigationController.navigationItem.title=@"Live Track";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark-Find polyLine Coords
-(void)DrawPolyLine
{
    if ([valuesArray count]>1)
    {
        for (int i=0; i<=[valuesArray count]-1; i++)
        {
                        [self.allPins removeAllObjects];
            if (i==[valuesArray count]-1) {
                for (int j=[[valuesArray objectAtIndex:i] intValue];j<[locationlist count]; j++)
                {
                    Vehiclelocationlist *list1= [locationlist objectAtIndex:j];
                    CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
                    Pin *newPin = [[Pin alloc]initWithCoordinate:coord];
                    [self.allPins addObject:newPin];
                    
                }
            }
            else
            {
            for (int j=[[valuesArray objectAtIndex:i] intValue];j<=[[valuesArray objectAtIndex:i+1] intValue]; j++)
            {
                Vehiclelocationlist *list1= [locationlist objectAtIndex:j];
                CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
                Pin *newPin = [[Pin alloc]initWithCoordinate:coord];
                [self.allPins addObject:newPin];
                
            }
            }
            
            [self drawLines:[colorsArray objectAtIndex:i]];
        }
    }
    else
    {
        [self.allPins removeAllObjects];
        for (int j=0 ;j<[locationlist count]; j++)
        {
            Vehiclelocationlist *list1= [locationlist objectAtIndex:j];
            CLLocationCoordinate2D coord = {.latitude =  [list1.latitude doubleValue], .longitude = [list1.longitude doubleValue]};
            Pin *newPin = [[Pin alloc]initWithCoordinate:coord];
            [self.allPins addObject:newPin];
            
        }
        [self drawLines:[colorsArray objectAtIndex:0]];
    }
    
    
    
}
#pragma mark-Find Colors using colorname
-(UIColor*)FindColor:(NSString *)colorname
{
    
    
    if ([colorname isEqualToString:@"redColor"]) {
        [UIColor redColor];
    }
    else if ([colorname isEqualToString:@"brownColor"]) {
        [UIColor brownColor];
    }
    else if ([colorname isEqualToString:@"cyanColor"]) {
        [UIColor cyanColor];
    }
    else if ([colorname isEqualToString:@"yellowColor"]) {
        [UIColor yellowColor];
    }
    else if ([colorname isEqualToString:@"magentaColor"]) {
        [UIColor magentaColor];
    }
    else if ([colorname isEqualToString:@"purpleColor"]) {
        [UIColor purpleColor];
    }
    else if ([colorname isEqualToString:@"blueColor"]) {
        [UIColor blueColor];
    }
    else if ([colorname isEqualToString:@"darkGrayColor"]) {
        [UIColor darkGrayColor];
    }
    return [UIColor redColor];
    
}
#pragma mark-DrawLine
- (IBAction)drawLines:(NSString*)sender {
    
    
    
    [self drawLineSubroutine:sender];
    [self drawLineSubroutine:sender];
    
}


- (void)drawLineSubroutine:(NSString*)colorname {
    
    // remove polyline if one exists
  //  [self.mapview removeOverlay:self.polyline];
    
    // create an array of coordinates from allPins
    CLLocationCoordinate2D coordinates[self.allPins.count];
    int i = 0;
    for (Pin *currentPin in self.allPins) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
//    NSLog(@"Line coords %@",self.allPins);
//    NSLog(@"method call with colorname %@",colorname);
    // create a polyline with all cooridnates
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:self.allPins.count];
     polyline.title=colorname;
    [self.mapview addOverlay:polyline];
    
    
    // for a laugh: how many polylines are we drawing here?
    self.title = [[NSString alloc]initWithFormat:@"%lu", (unsigned long)self.mapview.overlays.count];

    self.polyline = polyline;
    
    // create an MKPolylineView and add it to the map view
    
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
		
		MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
		polylineView.strokeColor = [UIColor redColor];
        
		polylineView.lineWidth = 3.0;
        NSString *colorname=overlay.title;
//         NSLog(@"method call with colorname in viewforOverlay %@",colorname);
       
        if ([colorname isEqualToString:@"redColor"]) {
            polylineView.strokeColor = [UIColor redColor];
        }
        else if ([colorname isEqualToString:@"brownColor"]) {
            polylineView.strokeColor = [UIColor brownColor];
        }
        else if ([colorname isEqualToString:@"cyanColor"]) {
            polylineView.strokeColor =[UIColor cyanColor];
        }
        else if ([colorname isEqualToString:@"yellowColor"]) {
            polylineView.strokeColor =  [UIColor yellowColor];
        }
        else if ([colorname isEqualToString:@"magentaColor"]) {
           polylineView.strokeColor = [UIColor magentaColor];
        }
        else if ([colorname isEqualToString:@"purpleColor"]) {
            polylineView.strokeColor =  [UIColor purpleColor];
        }
        else if ([colorname isEqualToString:@"blueColor"]) {
            polylineView.strokeColor =[UIColor blueColor];
        }
        else if ([colorname isEqualToString:@"darkGrayColor"]) {
           polylineView. strokeColor = [UIColor darkGrayColor];
        }
        self.lineView=polylineView;
        
		return polylineView;
        
	}
	
	return [[MKOverlayView alloc] initWithOverlay:overlay];
   
    
    // for a laugh: how many polylines are we drawing here?
   
}
#pragma mark mapView delegate functions

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
        if(csAnnotation.annotationType == CSMapAnnotationTypeNotRespondingImage)
		{
			NSString* identifier = @"NotResponding";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
            if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				
			}
			
			annotationView = imageAnnotationView;
		}
        if(csAnnotation.annotationType == CSMapAnnotationTypeSleepModeImage)
		{
			NSString* identifier = @"SleepMode";
			
			CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*)[self.mapview dequeueReusableAnnotationViewWithIdentifier:identifier];
            if(nil == imageAnnotationView)
			{
				imageAnnotationView = [[[CSImageAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
				
			}
			
			annotationView = imageAnnotationView;
		}
        //	annotationView.centerOffset=CGPointMake(100,100);
		[annotationView setEnabled:YES];
		[annotationView setCanShowCallout:NO];
		
		
	}
	
	
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
    CSImageAnnotationView* imageAnnotationView = (CSImageAnnotationView*) view;
	CSMapAnnotation* annotation = (CSMapAnnotation*)[imageAnnotationView annotation];
    
	
    
	
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





- (void)dealloc {
    
    
    
    
    [super dealloc];
    
    [mapview release];
    
    
}
@end
