//
//  OverSpeedViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 05/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "OverSpeedViewController.h"
#import "SBJSON.h"
#import "DateTimePicker.h"
#import "OverSpeedSearch.h"
#define  AppDelegate (GPSMobileTrackingAppDelegate *)[[UIApplication sharedApplication] delegate]
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif
@interface OverSpeedViewController ()
{
    databaseurl *du;
    DateTimePicker *picker;
    GPSMobileTrackingAppDelegate *delegate;
}
@end

@implementation OverSpeedViewController


@synthesize fromdate;
@synthesize todate;
@synthesize vecnumber;
@synthesize drivername;
@synthesize speedcount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - YLMenuItemActions
- (void)toolButtonTapped:(id)sender {
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[OverSpeedSearch class]]) {
            [view removeFromSuperview];
            [self.view setFrame:CGRectMake(0,0, 768,1024)];
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
        [self performSegueWithIdentifier:@"speedtolive" sender:self];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"speedtolive" sender:self];
        
    }
    
    
    
    
}

- (void)HistoryTapped {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"speedtohis" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"speedtohis" sender:self];
        
    }
    
}

- (void)TheftTapped {
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        [self performSegueWithIdentifier:@"speedtotheft" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"speedtotheft" sender:self];
        
    }
}
- (void)OverspeedTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
       // [self performSegueWithIdentifier:@"thefttospeed" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
      //  [self performSegueWithIdentifier:@"thefttospeed" sender:self];
        
    }
}
- (void)alertTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        // [self performSegueWithIdentifier:@"livetoalert" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        //[self performSegueWithIdentifier:@"livetoalert" sender:self];
        
    }
}
-(void)Search_Action:(id)sender
{
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[OverSpeedSearch class]]) {
            [view removeFromSuperview];
             [self.view setFrame:CGRectMake(0,0, 768,1024)];
        }
    }
   
    if (IS_IPAD) {
        OverSpeedSearch *search=[[OverSpeedSearch alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
       [self animateView:self.view down:YES];
         [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchDone" object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(RetriveDatas:) name:@"SearchDone"object:nil];
        
    }
    else
    {
       OverSpeedSearch *search=[[OverSpeedSearch alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
        [self animateView:self.view down:YES];
         [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchDone" object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(RetriveDatas:) name:@"SearchDone"object:nil];
        
    }
}
-(void)animateView:(UIView*)view down:(BOOL)down
{
    const int movementDistance = 63; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (down ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateView" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
//- (void)animateDropDown
//{
//    
//    
//    [UIView animateWithDuration: 0.7
//                          delay: 0.0
//                        options: UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         if (fullyOpen)
//                         {
//                              self.OverspeedDate.frame = CGRectOffset(self.OverspeedDate.frame, 0, -63);
//                             
//                          //   self.OverspeedDate.center = CGPointMake(self.OverspeedDate.frame.size.width / 2, -((self.OverspeedDate.frame.size.height / 2)+63 ));
//                              fullyOpen = NO;
//                         }
//                         else
//                         {
//                             self.OverspeedDate.frame = CGRectOffset(self.OverspeedDate.frame, 0, 63);
//                            // self.OverspeedDate.center = CGPointMake(self.OverspeedDate.frame.size.width / 2, ((self.OverspeedDate.frame.size.height / 2)+63 ));
//                             fullyOpen = YES;
//                         }
//                     }
//                     completion:^(BOOL finished){
//                         //  [delegate pullDownAnimated:fullyOpen];
//                     }];
//}
#pragma mark - Didload
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.topViewController.title=@"OverSpeed";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    fullyOpen=NO;
    UIButton* back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UIBarButtonItem *button11 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = button11;
    
  
    
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
        fixedItem1.width = 10;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem1,b]];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Test.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toolButtonTapped:)];
        homeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
        [homeButton setImage:[UIImage imageNamed:@"Home_Icon.png"] forState:UIControlStateNormal];
        [homeButton addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *homebutton = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 20;
        
        [self.navigationItem setRightBarButtonItems:@[fixedItem1,homebutton,fixedItem1,b]];
    }
    UIButton* searchButton;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        searchButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [searchButton setImage:[UIImage imageNamed:@"Search_Icon.png"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(Search_Action:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
        
       
        
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 10;
        
        [self.navigationItem setLeftBarButtonItems:@[fixedItem1,searchBarButton,fixedItem1]];
    }
    else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        searchButton= [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
        [searchButton setImage:[UIImage imageNamed:@"Search_Icon.png"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(Search_Action:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
      
        
        UIBarButtonItem *fixedItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem1.width = 20;
        
        [self.navigationItem setLeftBarButtonItems:@[fixedItem1,searchBarButton,fixedItem1]];
    }
    

    du=[[databaseurl alloc]init];
    delegate=AppDelegate;
    speedcount.text=@"";
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    NSString *driver_name=[[NSUserDefaults standardUserDefaults]objectForKey:@"driver_name"];
    vecnumber.text=vehicleregno;
    drivername.text=driver_name;
    
    self.ownername.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"OwnerFirstName"];
   
    BusNameList *bus_list= [delegate.Vehicle_List objectAtIndex:[[[NSUserDefaults standardUserDefaults]valueForKey:@"selected_row"] intValue]];
    if ([bus_list.device_status isEqualToString:@"0"]) {
        self.devicestatus.text=@"Switched Off";
    }
    else if ([bus_list.device_status isEqualToString:@"1"]) {
        self.devicestatus.text=@"Active Mode";
    }
    else if ([bus_list.device_status isEqualToString:@"2"])
    {
        self.devicestatus.text=@"No Signal";
    }
    else if ([bus_list.device_status isEqualToString:@"3"])
    {
        self.devicestatus.text=@"Sleep Mode";
        
    }
    else
        self.devicestatus.text=@"Switched Off";
    
}
#pragma mark -OverspeedCount Method at didload
-(void)CountOverSpeed
{
    
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        NSString *driver_name=[[NSUserDefaults standardUserDefaults]objectForKey:@"driver_name"];
        vecnumber.text=vehicleregno;
        drivername.text=driver_name;
        NSString *response=[self countSpeed:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
        
        
        if (parsedvalue == nil)
        {
            [HUD hide:YES];
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            [HUD hide:YES];
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            if([[menu objectForKey:@"success"]isEqualToString:@"Yes"])
            {
                speedcount.text=[menu objectForKey:@"total"];
                vecnumber.text=vehicleregno;
                drivername.text=driver_name;
            }
            
        }
    }
    
    
}



#pragma mark -Home Action

- (IBAction)home:(id)sender {
    for(UIView *view in [[[UIApplication sharedApplication] keyWindow] subviews]){
        if ([view isKindOfClass:[OverSpeedSearch class]]) {
            [view removeFromSuperview];
            [self.view setFrame:CGRectMake(0,0, 768,1024)];
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




#pragma mark -Get OverSpeedCount

- (IBAction)RetriveDatas:(id)sender {
    
    [self animateView:self.view down:NO];
    
//    NSLog(@"Object received %@",[sender valueForKey:@"object"]);
  
   fromdate= [[sender valueForKey:@"object"] valueForKey:@"Selected_FromDate"];
   todate =[[sender valueForKey:@"object"] valueForKey:@"Selected_ToDate"];
    // NSLog(@"Failure %@",fromdate);
   //  NSLog(@"Failure %@",todate);
        if (([fromdate length]>0)&&([todate length]>0))
        {
         
            HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            HUD.mode=MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Please wait";
            [HUD show:YES];
            [self performSelector:@selector(CountOverSpeedByTime) withObject:self afterDelay:0.1f];
        }
    else
    {
        NSLog(@"Failure");
    }
    
        
    
}
#pragma mark -Search by specified time
-(void)CountOverSpeedByTime
{
    
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        NSString *driver_name=[[NSUserDefaults standardUserDefaults]objectForKey:@"driver_name"];
        
        NSString *response=[self countSpeedInTime:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
           //    NSLog(@"response %@",response);
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
        
        
        if (parsedvalue == nil)
        {
            [HUD hide:YES];
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            [HUD hide:YES];
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            //            NSLog(@"menu %@",menu);
            if([[menu objectForKey:@"success"]isEqualToString:@"Yes"])
            {
                speedcount.text=[menu objectForKey:@"total"];
                vecnumber.text=vehicleregno;
                drivername.text=driver_name;
            }
            
        }
    }
    
    
}
-(NSString *)countSpeedInTime:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    NSString * orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"OverSpeed.php?service=VehicleOverSpeedInTime";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&orgid=%@&from=%@&to=%@&%@=%@",firstEntity,value1,orgid,fromdate,todate,secondEntity,value2];
    // NSLog(@"post %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
-(NSString *)countSpeed:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    NSString * orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"OverSpeed.php?service=VehicleOverSpeedCount";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&orgid=%@&%@=%@",firstEntity,value1,orgid,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"SearchDone" object:nil];
    [super dealloc];
}
@end
