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
@interface OverSpeedViewController ()
{
     databaseurl *du;
    DateTimePicker *picker;
}
@end

@implementation OverSpeedViewController
@synthesize bgimage;
@synthesize welcome;
@synthesize home;
@synthesize logout;
@synthesize segment;

@synthesize fromdate;
@synthesize todate;

@synthesize vecnumber;
@synthesize vecnumberlab;
@synthesize drivername;
@synthesize drivernamelab;
@synthesize speedcount;
@synthesize speedcountlab;
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
    du=[[databaseurl alloc]init];
//    HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
//    HUD.mode=MBProgressHUDModeIndeterminate;
//    HUD.delegate = self;
//    HUD.labelText = @"Please wait";
//    [HUD show:YES];
    speedcount.text=@"";
    NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    NSString *driver_name=[[NSUserDefaults standardUserDefaults]objectForKey:@"driver_name"];
    vecnumber.text=vehicleregno;
    drivername.text=driver_name;
//     [self performSelector:@selector(CountOverSpeed) withObject:self afterDelay:0.1f];
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
    [segment setSelectedSegmentIndex:3];
    NSString *filename = [du imagecheck:@"message.jpg"];
    NSLog(@"image name %@",filename);
    bgimage.image = [UIImage imageNamed:filename];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *strDate =[dateFormatter stringFromDate:[NSDate date]];
//    fromdate.text=strDate;
//    todate.text=strDate;

}
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
            [self performSegueWithIdentifier:@"speedtolive" sender:self];
            
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"speedtolive" sender:self];
            
        }
    }
    if ([sender selectedSegmentIndex]==1)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"speedtohis" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"speedtohis" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==2)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
              [self performSegueWithIdentifier:@"speedtotheft" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
              [self performSegueWithIdentifier:@"speedtotheft" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==3)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            //[self performSegueWithIdentifier:@"livetospeed" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
          //  [self performSegueWithIdentifier:@"livetospeed" sender:self];
            
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

- (IBAction)frombuttonClicked:(id)sender {
//    fromdateselection.hidden=NO;
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 320, 44)];
//    textField.text         = @"done";
//    textField.userInteractionEnabled=YES;
//    [self.view addSubview:textField];
//    
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    toolbar.barStyle   = UIBarStyleBlackTranslucent;
//    
//    UIBarButtonItem *itemDone  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
//    UIBarButtonItem *itemSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    
//    toolbar.items = @[itemSpace,itemDone];
//    
//    UIDatePicker *datePicker =fromdateselection;
//    [fromdateselection setFrame:CGRectMake(0, 0, 320, 216)];
//   
//      
//    textField.inputAccessoryView = toolbar;
//    textField.inputView          = datePicker;
//    
//    [textField becomeFirstResponder];
    
    
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
        [picker setMode:UIDatePickerModeDate];
        picker.picker.tag=1;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    
}
-(void)pickerChanged:(id)sender {
    UIDatePicker *dp=(UIDatePicker*)sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    if (dp.tag==1) {
          self.fromdate.text = strDate;
    }
    else if (dp.tag==2) {
        self.todate.text = strDate;
    }
    //    selectedDate = picker.date;
    //    [button setTitle:[dateFormatter stringFromDate:selectedDate] forState:UIControlStateNormal];
}

-(void)donePressed {
    UIDatePicker *dp=picker.picker;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    if (dp.tag==1) {
        self.fromdate.text = strDate;
    }
    else if (dp.tag==2) {
        self.todate.text = strDate;
    }
    [picker removeFromSuperview];
//    NSLog(@"Done button tapped");
    
}

-(void)cancelPressed {
    [picker removeFromSuperview];
//    NSLog(@"Cancel pressed");
}

- (IBAction)tobuttonClicked:(id)sender {
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
        [picker setMode:UIDatePickerModeDate];
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
        [picker setMode:UIDatePickerModeDate];
          picker.picker.tag=2;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
}



- (IBAction)search:(id)sender {
   
    if ((![fromdate.text isEqualToString:@"From Date"])&&(![todate.text isEqualToString:@"To Date"])) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        HUD.mode=MBProgressHUDModeIndeterminate;
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        [HUD show:YES];
        [self performSelector:@selector(CountOverSpeedByTime) withObject:self afterDelay:0.1f];
    }
    else
    {
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
   
}
-(void)CountOverSpeedByTime
{
    
    du=[[databaseurl alloc]init];
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *vehicleregno=[[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
        NSString *driver_name=[[NSUserDefaults standardUserDefaults]objectForKey:@"driver_name"];
        
        NSString *response=[self countSpeedInTime:@"vecid" ForValue1:vehicleregno EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
//        NSLog(@"response %@",response);
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
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&orgid=%@&from=%@&to=%@&%@=%@",firstEntity,value1,orgid,fromdate.text,todate.text,secondEntity,value2];
   // NSLog(@"post %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
- (void)dealloc {
  
    [super dealloc];
}
@end
