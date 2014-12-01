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
#pragma mark - Zooming  MapView
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
        
    }
    else
    {
        
   SearchMenu * vc=[[SearchMenu alloc]initWithFrame:CGRectMake(0,0,320,568)]; //Initialize this way otherwise you cannt access controllers from view.
        
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
    
    
    CLLocationCoordinate2D coord = {.latitude =  22.3512639, .longitude =78.9542827};
    MKCoordinateSpan span = {.latitudeDelta =  30, .longitudeDelta =  30};
    //  MKCoordinateRegion region = {coord, span};
    MKCoordinateRegion region = { .center = coord, .span = span };
    
    
    
    [mapview setRegion:region animated:YES];
    [segment setSelectedSegmentIndex:1];
    
    stepper_initial_value=stepper.value;
    
    
    // Do any additional setup after loading the view.
    du=[[databaseurl alloc]init];
    //    NSString *filename = [du imagecheck:@"historytrack.jpg"];
    //    NSLog(@"image name %@",filename);
    //     imageview.image = [UIImage imageNamed:filename];
    
    mapview.delegate=self;
    
    
    
    
}
#pragma mark - Search Action _ Date Selection
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
#pragma mark - FromTime
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
    //    NSLog(@"time in picker %@",dp.date);
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
#pragma mark - To time Picker
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

#pragma mark - PickerAction

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
#pragma mark - Date and time comparison
-(BOOL)From_to_dateCheck
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //   NSLocale *indianEnglishLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"] autorelease];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
    //   [formatter setLocale:indianEnglishLocale];
    //    [formatter setTimeZone:timeZone];
    NSString *fromtime1=[NSString stringWithFormat:@"%@ %@",selecteddate.text,fromtime.text];
    NSString *totime1=[NSString stringWithFormat:@"%@ %@",selecteddate.text,totime.text];
    NSDate *date1= [formatter dateFromString:fromtime1];
    NSDate *date2 = [formatter dateFromString:totime1];
    NSComparisonResult result = [date1 compare:date2];
    //    NSLog(@"from time %@",date1);
    //     NSLog(@"to time %@",date2);
    //     NSLog(@"result %ld",result);
    if(result == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        return 0;
    }
    else if(result == NSOrderedAscending)
    {
        NSLog(@"date2 is later than date1");
        return 1;
    }
    else
    {
        NSLog(@"date1 is equal to date2");
        return 1;
    }
    return 0;
}

#pragma mark - search Action
- (IBAction)search:(id)sender {
    if ((![selecteddate.text isEqualToString:@"Select Date"])&&(![fromtime.text isEqualToString:@"From"])&&(![totime.text isEqualToString:@"To"]))
    {
        
        BOOL res= [self From_to_dateCheck];
        if (res)
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
            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"To time must be greater than from time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [self styleCustomAlertView:alertView];
            [self addButtonsWithBackgroundImagesToAlertView:alertView];
            [alertView show];
        }
        
        
        
        
        
        
    }
    else if ([selecteddate.text isEqualToString:@"Select Date"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    else if ([fromtime.text isEqualToString:@"From"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select from time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    else if ([totime.text isEqualToString:@"To"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select to time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
#pragma mark - Http Method to getList
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
