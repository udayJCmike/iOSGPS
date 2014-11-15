//
//  GPSMobileTrackingViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "GPSMobileTrackingViewController.h"

@interface GPSMobileTrackingViewController ()
{
    databaseurl *du;
    GPSMobileTrackingAppDelegate *delegate;
  

}
@end

@implementation GPSMobileTrackingViewController
int c;

@synthesize imageview;
@synthesize username;
@synthesize password;
@synthesize login;
@synthesize reset;
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)login:(id)sender
{
    [self dismissKeyboard];
    if (([username.text length]==0) &&
        ([password.text length]==0))
    {
        c=0;
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Enter login credentials" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    else if (([username.text length]>0) &&
             ([password.text length]==0))
        
    {
        c=0;
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Enter password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
        
    }
    
    
    else if (([username.text length]==0) &&
             ([password.text length]>0))
    {
        c=0;
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Enter username" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
        
    }
    else
    {
        if (([username.text length]>0)&&([password.text length]>0))
        {
            c=1;
            if (c==1)
                
            {
                HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
                HUD.mode=MBProgressHUDModeIndeterminate;
                HUD.delegate = self;
                HUD.labelText = @"Please wait";
                [HUD show:YES];
                if ([[du submitvalues]isEqualToString:@"Success"])
                {
                    [self performSelector:@selector(checkdata) withObject:self afterDelay:0.1f];
                    
                }
                else
                {
                    //[HUD hide:YES];
                    HUD.labelText = @"Check network connection";
                    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
                    HUD.mode = MBProgressHUDModeCustomView;
                    [HUD hide:YES afterDelay:1];
                }
                
            }
            
        }
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == username)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if (range.length == 0 && range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
        {
            
            return NO;
        }
    }
    else if(textField == password)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if (range.length == 0 && range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
        {
            
            return NO;
        }
    }
    return YES;
}
-(void)checkdata
{
    NSString *response=[self HttpPostEntityFirst1:@"username" ForValue1:username.text  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *parsedvalue = [json objectWithString:response error:&error];
    
    //NSLog(@"%@ parsedvalue",parsedvalue);
    if (parsedvalue == nil)
    {
        
        //NSLog(@"parsedvalue == nil");
        
    }
    else
    {
        
        NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
        if ([[menu objectForKey:@"servicename"] isEqualToString:@"Login Data"])
        {
            if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
            {
                
                
                [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"orgid"] forKey:@"orgid"];
                [[NSUserDefaults standardUserDefaults]setValue:username.text forKey:@"username"];
                 [[NSUserDefaults standardUserDefaults]setValue:password.text forKey:@"password"];
                [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"role"] forKey:@"role"];
              //  NSLog(@"role %@",[menu objectForKey:@"role"]);
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self getVehicleList];
//                [self performSelector:@selector(getVehicleList) withObject:self afterDelay:0.1];
                delegate.login_status=@"1";
                [delegate DownloadVehicleListInBackend];
                username.text=@"";
                password.text=@"";
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPad" bundle:nil];
                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                    [self.navigationController pushViewController:initialvc animated:YES];
                    //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                    //    [self presentModalViewController:initialvc animated:YES];
                }
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
                {
                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPhone" bundle:nil];
                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                    [self.navigationController pushViewController:initialvc animated:YES];
                    //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
                    //    [self presentModalViewController:initialvc animated:YES];
                }
                
                [HUD hide:YES];
                
            }
            else if ([[menu objectForKey:@"success"] isEqualToString:@"No"])
                
            {
                
                
                [HUD hide:YES];
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Invalid username or password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
                
                username.text=@"";
                password.text=@"";
                delegate.login_status=@"0";
                
            }
            
        }
    }
    
    
}
-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Login.php?service=login";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&password=%@&role=0&%@=%@",firstEntity,value1,password.text,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton=YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad
{
    username.delegate=self;
    password.delegate=self;
    delegate=AppDelegate;
    self.navigationController.navigationBarHidden=YES;
    self.navigationItem.hidesBackButton=YES;
    [super viewDidLoad];
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == username && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 190;
            }
            
            if (con.firstItem == password && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 230;
            }
            if (con.firstItem == login && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 294;
            }
            if (con.firstItem == reset && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 294;
            }
        }
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    du=[[databaseurl alloc]init];
    
    NSString *filename = [du imagecheck:@"login.jpg"];
    NSLog(@"image name %@",filename);
    

    
    imageview.image = [UIImage imageNamed:filename];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
}
-(void)dismissKeyboard
{
    [username resignFirstResponder];
    [password resignFirstResponder];
}
- (IBAction)reset:(id)sender {
    username.text=@"";
    password.text=@"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getVehicleList
{
    du=[[databaseurl alloc]init];
    delegate.login_status=@"1";
    delegate=AppDelegate;
//    NSLog(@"method called from timer");
    if ([[du submitvalues]isEqualToString:@"Success"])
    {
        
        NSString *orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
        
        NSString *response=[self GetVehicleList:@"orgid" ForValue1:orgid  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
        
        NSError *error;
        SBJSON *json = [[SBJSON new] autorelease];
        
        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
        NSMutableArray *  list=[[NSMutableArray alloc]init];
       /// NSLog(@"%@ parsedvalue",parsedvalue);
        if (parsedvalue == nil)
        {
            
            //NSLog(@"parsedvalue == nil");
            
        }
        else
        {
            
            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
            NSArray *datas=[menu objectForKey:@"vehicle List"];
            
            
            //     To check whether its having data or not
            //              NSLog(@"datas %lu",(unsigned long)[datas count]);
            
            if ([datas count]>0)
            {
                
                for (id anUpdate1 in datas)
                {
                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
                    
                    BusNameList *list1=[[BusNameList alloc]init];
                    list1.vehicle_reg_no=[arrayList1 objectForKey:@"vehicle_reg_no"];
                    list1.speed =[arrayList1 objectForKey:@"speed"];
                    list1.device_status =[arrayList1 objectForKey:@"device_status"];
                    list1.bus_tracking_timestamp =[arrayList1 objectForKey:@"bus_tracking_timestamp"];
                    list1.address =[arrayList1 objectForKey:@"address"];
                    list1.driver_name =[arrayList1 objectForKey:@"driver_name"];
                     list1.alarm_status =[arrayList1 objectForKey:@"alarm_status"];
                    if ([list1.alarm_status isEqualToString:@"2"])
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlaySound"
                                                                            object:self
                                                                          userInfo:nil];
                    }
                    else
                    {
                      //  [[NSNotificationCenter defaultCenter] postNotificationName:@"StopSound" object:self  userInfo:nil];
                    }
                    [list addObject:list1];
                }
                
            }
            
        }
        delegate.Vehicle_List=list;
    }
    else
    {
        NSLog(@"failure");
    }
  
 
}
-(NSString *)GetVehicleList:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Vehicledetails.php?service=vehiclelist";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    //    NSLog(@"post %@",post);
    NSString *data=[du returndbresult:post URL:url];
    //    NSLog(@"datas in wel %@",data);
    return data;
}

-(void)LoginWithSession
{
     du=[[databaseurl alloc]init];
    NSString *response=[self SessionLogin:@"username" ForValue1:[[NSUserDefaults standardUserDefaults]valueForKey:@"username"]  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *parsedvalue = [json objectWithString:response error:&error];
   
   // NSLog(@"%@ parsedvalue",parsedvalue);
    if (parsedvalue == nil)
    {
        
        //NSLog(@"parsedvalue == nil");
        
    }
    else
    {
        
        NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
        if ([[menu objectForKey:@"servicename"] isEqualToString:@"Login Data"])
        {
            if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
            {
                
                
                [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"orgid"] forKey:@"orgid"];
               
                [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"role"] forKey:@"role"];
               
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self getVehicleList];

                delegate.login_status=@"1";
                [delegate DownloadVehicleListInBackend];               
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPad" bundle:nil];
                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                    [self.navigationController pushViewController:initialvc animated:YES];
                   
                }
                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
                {
                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPhone" bundle:nil];
                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                    [self.navigationController pushViewController:initialvc animated:YES];
                    
                }
                
                
            }
            else if ([[menu objectForKey:@"success"] isEqualToString:@"No"])
                
            {
                
                
                [HUD hide:YES];
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Invalid username or password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
                
                
                delegate.login_status=@"0";
                
            }
            
        }
    }
    
  // [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTable" object:self  userInfo:nil];
}
-(NSString *)SessionLogin:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    
    
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"Login.php?service=login";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&password=%@&role=0&%@=%@",firstEntity,value1,[[NSUserDefaults standardUserDefaults]valueForKey:@"password"],secondEntity,value2];
    NSURL *url = [NSURL URLWithString:url2];
    
    return [du returndbresult:post URL:url];
}
- (void)dealloc {
    
    [super dealloc];
}
@end
