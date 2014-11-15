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
@synthesize switchres;
@synthesize alarmswitch;
@synthesize bgimage;
@synthesize welcome;
@synthesize home;
@synthesize logout;
@synthesize segment;
@synthesize timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    alertblink.hidden=NO;
//     [self displayLabel];
    du=[[databaseurl alloc]init];
    HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    HUD.mode=MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    [HUD show:YES];
    [self performSelector:@selector(statusAction) withObject:self afterDelay:0.1f];
    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
  
    //     [alarmswitch setTintColor:[UIColor colorWithRed:255 green:156 blue:0 alpha:0.1f]];
   

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
    [segment setSelectedSegmentIndex:2];
    [onoff setSelectedSegmentIndex:1];
    
    delegate=AppDelegate;
    
    path   =   [[NSBundle mainBundle] pathForResource:@"beep1" ofType:@"caf"];
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
 
    NSString *filename = [du imagecheck:@"message.jpg"];
    NSLog(@"image name %@",filename);
    bgimage.image = [UIImage imageNamed:filename];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)segmentaction:(id)sender {
    if ([sender selectedSegmentIndex]==0)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"thefttolive" sender:self];
            
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"thefttolive" sender:self];
            
        }
    }
    if ([sender selectedSegmentIndex]==1)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"thefttohis" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"thefttohis" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==2)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
           ///  [self performSegueWithIdentifier:@"histoalert" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            //  [self performSegueWithIdentifier:@"histoalert" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==3)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"thefttospeed" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"thefttospeed" sender:self];
            
        }
        
    }

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

- (IBAction)switchaction:(id)sender {
  
//    [HUD hide:YES];
//    @try
//    {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(insertAction) object:self];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateAction) object:self];
//    }
//    @catch (NSException *exception)
//    {
//        NSLog(@"exception in switch");
//    }
//   
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    HUD.mode=MBProgressHUDModeIndeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Please wait";
    [HUD show:YES];
    if (alarmswitch.on) {
        switchres.text=@"On";
        NSLog(@"switch on action");
          [self performSelector:@selector(insertAction) withObject:self afterDelay:0.1f];
    }
    else if (!alarmswitch.on)
    {
        NSLog(@"switch off action");
        switchres.text=@"Off";
          [self performSelector:@selector(updateAction) withObject:self afterDelay:0.1f];
    }
    

}
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
                switchres.text=@"Off";
                [alarmswitch setOn:NO animated:YES];
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
                switchres.text=@"On";
                [alarmswitch setOn:YES animated:YES];
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
                    switchres.text=@"On";
                    [alarmswitch setOn:YES animated:YES];
                      [onoff setSelectedSegmentIndex:0];
                    if (!timer) {
                        NSLog(@"timer start");
                        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(CheckTheftAlarmStatus)  userInfo:nil  repeats:YES];
                    }
                    
                }
                else if ([status isEqualToString:@"2"]) {
                    alertblink.hidden=NO;
                    switchres.text=@"On";
                    [alarmswitch setOn:YES animated:YES];
                     [onoff setSelectedSegmentIndex:0];
                    [self displayLabel];
                }
                else
                {
                      [onoff setSelectedSegmentIndex:1];
                    switchres.text=@"Off";
                    [alarmswitch setOn:NO animated:YES];
                }
            }
            
        }
    }
    
    
}
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
                    switchres.text=@"On";
                    [alarmswitch setOn:YES animated:YES];
                    [onoff setSelectedSegmentIndex:0];
                    
                }
                else if ([status isEqualToString:@"2"]) {
                    alertblink.hidden=NO;
                    switchres.text=@"On";
                    [alarmswitch setOn:YES animated:YES];
                    [onoff setSelectedSegmentIndex:0];
                    [self displayLabel];
                }
                else
                {
                    [onoff setSelectedSegmentIndex:1];
                    switchres.text=@"Off";
                    [alarmswitch setOn:NO animated:YES];
                }
            }
            
        }
    }
 
    
}
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

    [super dealloc];
  
}
@end
