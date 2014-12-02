//
//  TheftAlarmViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 04/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "TheftAlarmViewController.h"
#import "MBProgressHUD.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#define interval 120
@interface TheftAlarmViewController ()
{
    databaseurl *du;
    NSString *path;
    NSURL *soundUrl;
    NSError *error;
    GPSMobileTrackingAppDelegate *delegate;
}
@end

@implementation TheftAlarmViewController
@synthesize onoff;
@synthesize alertblink;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - customSwitch delegate
-(void)customSwitchSetStatus:(CustomSwitchStatus)status
{
    switch (status) {
        case CustomSwitchStatusOn:
        {
            NSLog(@"on");
            [onoff setSelectedSegmentIndex:0];
            HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            HUD.mode=MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Please wait";
            [HUD show:YES];
            [self performSelector:@selector(insertAction) withObject:self afterDelay:0.1f];
        }
            break;
        case CustomSwitchStatusOff:
        {
            NSLog(@"off");
            [onoff setSelectedSegmentIndex:1];
            HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
            HUD.mode=MBProgressHUDModeIndeterminate;
            HUD.delegate = self;
            HUD.labelText = @"Please wait";
            [HUD show:YES];
            [self performSelector:@selector(updateAction) withObject:self afterDelay:0.1f];
        }
            break;
        default:
            break;
    }
}
#pragma mark - YLMenuItemActions
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
        [self performSegueWithIdentifier:@"thefttolive" sender:self];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"thefttolive" sender:self];
        
    }
    
    
    
    
}

- (void)HistoryTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"thefttohis" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"thefttohis" sender:self];
        
    }
}

- (void)TheftTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        ///  [self performSegueWithIdentifier:@"histoalert" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        //  [self performSegueWithIdentifier:@"histoalert" sender:self];
        
    }
}
- (void)OverspeedTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"thefttospeed" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"thefttospeed" sender:self];
        
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
#pragma mark - DidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
 self.navigationController.topViewController.title=@"Theft Alarm";
    _theft_Custom.arrange = CustomSwitchArrangeONLeftOFFRight;
    _theft_Custom.onImage = [UIImage imageNamed:@"switchOne_on.png"];
    _theft_Custom.offImage = [UIImage imageNamed:@"switchOne_off.png"];
    //_theft_Custom.status1 = CustomSwitchStatusOff;
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
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


    du=[[databaseurl alloc]init];
    HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    HUD.mode=MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    [HUD show:YES];
    [self performSelector:@selector(statusAction) withObject:self afterDelay:0.1f];
    
//    self.greyView.clipsToBounds=YES;
//    self.greyView.layer.cornerRadius=10;
  
    //     [alarmswitch setTintColor:[UIColor colorWithRed:255 green:156 blue:0 alpha:0.1f]];
   

    
    [onoff setSelectedSegmentIndex:1];
    
    delegate=AppDelegate;
    
    NSString *tonename=[[NSUserDefaults standardUserDefaults]valueForKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
    if ([tonename length]>0) {
         path   =   [[NSBundle mainBundle] pathForResource:tonename ofType:@"mp3"];
    }
    else
          path   =   [[NSBundle mainBundle] pathForResource:@"Red_Alert" ofType:@"mp3"];
  
    soundUrl = [NSURL fileURLWithPath:path];
  
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        _audioPlayer.delegate = self;
       // [_audioPlayer setNumberOfLoops:3];
    }
 
    self.VecRegNo.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"vehicleregno"];
    self.DriverName.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"driver_name"];
    self.OwnerName.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"OwnerFirstName"];
     BusNameList *bus_list= [delegate.Vehicle_List objectAtIndex:[[[NSUserDefaults standardUserDefaults]valueForKey:@"selected_row"] intValue]];
    if ([bus_list.device_status isEqualToString:@"0"]) {
       self.DeviceStatus.text=@"Switched Off";
    }
    else if ([bus_list.device_status isEqualToString:@"1"]) {
           self.DeviceStatus.text=@"Active Mode";
    }
    else if ([bus_list.device_status isEqualToString:@"2"])
    {
           self.DeviceStatus.text=@"No Signal";
    }
    else if ([bus_list.device_status isEqualToString:@"3"])
    {
            self.DeviceStatus.text=@"Sleep Mode";
        
    }
    else
           self.DeviceStatus.text=@"Switched Off";
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CustomAlertView
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


#pragma mark - Home
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

- (IBAction)of_off:(id)sender {
    HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    HUD.mode=MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    [HUD show:YES];
    if (onoff.selectedSegmentIndex==0) {
           [self performSelector:@selector(insertAction) withObject:self afterDelay:0.1f];
    }
    else if (onoff.selectedSegmentIndex==1)
    {
        [self performSelector:@selector(updateAction) withObject:self afterDelay:0.1f];
    }
}


#pragma mark - InsertStatus
-(void)insertAction
{
     du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        
        NSString * orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
      
        NSString *response=[self InsertAction:@"orgid" ForValue1:orgid EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
//        NSLog(@"parsedvalue %@",parsedvalue);
        
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
                if (!timer) {
                    NSLog(@"timer start");
                    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(CheckTheftAlarmStatus)  userInfo:nil  repeats:YES];
                }
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Theft alarm turned on." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
            else
            {
                [HUD hide:YES];
                 _theft_Custom.status1 = CustomSwitchStatusOff;
                [onoff setSelectedSegmentIndex:1];
               
               
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Can't reachable" message:@"Make sure the device is turned on. Try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
                
            }
        }
    }
     [HUD hide:YES];
 
}
#pragma mark - UpdateStatus
-(void)updateAction
{
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        
        NSString *response=[self UpdateAction:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
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
                alertblink.hidden=YES;
          BusNameList *bus_list= [delegate.Vehicle_List objectAtIndex:[[[NSUserDefaults standardUserDefaults]valueForKey:@"selected_row"] intValue]];
                [bus_list setAlarm_status:@"0"];
                [delegate.Vehicle_List replaceObjectAtIndex:[[[NSUserDefaults standardUserDefaults]valueForKey:@"selected_row"] intValue] withObject:bus_list];

                 [self.view.layer removeAllAnimations];
                    [_audioPlayer pause];
                    [_audioPlayer stop];
                    _audioPlayer=nil;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StopSound"   object:self userInfo:nil];
                
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Theft alarm turned off." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
            else
            {
                 _theft_Custom.status1 = CustomSwitchStatusOn;
                  [onoff setSelectedSegmentIndex:0];
                if (!timer) {
                    NSLog(@"timer start");
                    timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(CheckTheftAlarmStatus)  userInfo:nil  repeats:YES];
                }
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Can't reach server." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
                
            }
        }
    }
}
#pragma mark - GetStatusAction
-(void)statusAction
{
    
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        
        NSString *response=[self StatusCheck:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
        
//        NSLog(@"parsedvalue %@",parsedvalue);
        if (parsedvalue == nil)
        {
            [HUD hide:YES];
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
//            NSLog(@"parsedvalue else");
            [HUD hide:YES];
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            if([[menu objectForKey:@"success"]isEqualToString:@"Yes"])
            {
                NSString *status=[menu objectForKey:@"status"];
//                NSLog(@"%@ status recevied ",status);
                if ([status isEqualToString:@"1"]) {
                     _theft_Custom.status1 = CustomSwitchStatusOn;
                      [onoff setSelectedSegmentIndex:0];
                    if (!timer) {
                        NSLog(@"timer start");
                        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(CheckTheftAlarmStatus)  userInfo:nil  repeats:YES];
                    }
                    
                }
                else if ([status isEqualToString:@"2"]) {
                    alertblink.hidden=NO;
                     _theft_Custom.status1 = CustomSwitchStatusOn;
                    
                     [onoff setSelectedSegmentIndex:0];
                    [self displayLabel];
                }
                else
                {
                     _theft_Custom.status1 = CustomSwitchStatusOff;
                      [onoff setSelectedSegmentIndex:1];
                  
                }
            }
            
        }
    }
    
    
}
#pragma mark - CheckFrequentlyStatusAction
-(void)CheckTheftAlarmStatus
{
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        
        NSString *response=[self StatusCheck:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
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
            //            NSLog(@"parsedvalue else");
           
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            if([[menu objectForKey:@"success"]isEqualToString:@"Yes"])
            {
                NSString *status=[menu objectForKey:@"status"];
                //                NSLog(@"%@ status recevied ",status);
                if ([status isEqualToString:@"1"]) {
                     _theft_Custom.status = CustomSwitchStatusOn;
                    [onoff setSelectedSegmentIndex:0];
                    
                }
                else if ([status isEqualToString:@"2"]) {
                    alertblink.hidden=NO;
                     _theft_Custom.status = CustomSwitchStatusOn;
                    [onoff setSelectedSegmentIndex:0];
                    [self displayLabel];
                }
                else
                {
                    [onoff setSelectedSegmentIndex:1];
                   _theft_Custom.status = CustomSwitchStatusOff;
                }
            }
            
        }
    }
 
    
}
#pragma mark - Animate Label
-(void)displayLabel
{
//    if (_audioPlayer) {
//        [_audioPlayer prepareToPlay];
//        [_audioPlayer play];
//    }
//    else{
//       // NSLog(@"audio player not init");
//    }
//   
 
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [alertblink setAlpha:0.0];
    [UIView setAnimationDelay:0.40f];
    [UIView commitAnimations];
}
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
      [alertblink setAlpha:1.0];
    [self displayLabel];
}
#pragma mark - HTTPMethods
-(NSString *)InsertAction:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
   
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"TheftAlarm.php?service=VehicleTheftAlarmInsert";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&vecid=%@&%@=%@",firstEntity,value1,vehicleregno,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
   // NSLog(@"post %@",post);
    return [du returndbresult:post URL:url];
}
-(NSString *)UpdateAction:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
   
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"TheftAlarm.php?service=VehicleTheftAlarmUpdate";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
-(NSString *)StatusCheck:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"TheftAlarm.php?service=VehicleTheftAlarmStatus";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
-(void)viewWillDisappear:(BOOL)animated
{
    if ([timer isValid]) {
        //        NSLog(@"timer stopped in will disappeae");
        [timer invalidate];
    }
    [self.view.layer removeAllAnimations];
     [_audioPlayer pause];
        [_audioPlayer stop];
    _audioPlayer=nil;
 
}
- (void)dealloc {

    [_DeviceStatus release];
    [_greyView release];
    [_theft_Custom release];
    [super dealloc];
  
}
@end
