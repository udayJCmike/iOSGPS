//
//  alertmessageViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "alertmessageViewController.h"
#import "databaseurl.h"
#import "TTAlertView.h"
#import "WelcomeViewController.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface alertmessageViewController ()
{
    databaseurl *du;
    NSString *orgid;
    NSString *vehicleNo;
    NSString *route_no;
    NSMutableArray *mobileNumbers;
}
@end

@implementation alertmessageViewController
@synthesize activityIndicator;
@synthesize sendmessage;
@synthesize segment;
@synthesize welcome;
@synthesize imageview;
@synthesize alertMessageTextView;
@synthesize home;
@synthesize logout;
@synthesize clearmessage;
@synthesize textwidth;
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
    self.activityIndicator.hidden=YES;
    
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
            if (con.firstItem == alertMessageTextView && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 170;
                self.textwidth.constant=297;
                
            }
            if (con.firstItem == sendmessage && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =315;
            }
            if (con.firstItem == clearmessage && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =315;
                
                
            }
            
        }
    }
    
    alertMessageTextView.clipsToBounds = YES;
    NSString *role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    
    if ([role isEqualToString:@"ROLE_ADMIN"]) {
           //[segment removeSegmentAtIndex:3 animated:YES];
    }
    else  if (([role isEqualToString:@"ROLE_PCLIENT"]) ||   ([role isEqualToString:@"ROLE_FCLIENT"]))
    {
       // [segment removeSegmentAtIndex:2 animated:YES];
        [segment setTitle:@"Theft Alarm" forSegmentAtIndex:2];
    }

    du=[[databaseurl alloc]init];
    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
    orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
    vehicleNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"vehicleregno"];
    alertMessageTextView.layer.cornerRadius = 5;
    mobileNumbers = [[NSMutableArray alloc]init];
    [self getRouteNumber];
    [self getMobileNumbers];
    alertMessageTextView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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
    NSString *filename = [du imagecheck:@"message.jpg"];
    NSLog(@"image name %@",filename);
    
    //    for (int i = 0; i<mobileNumbers.count; i++)
    //    {
    //        NSLog(@"The Mobile Number of the Student/Person of Organisation id %@ and in Vehicle number %@ is : %@",orgid,vehicleNo,[mobileNumbers objectAtIndex:i]);
    //    }
    
    imageview.image = [UIImage imageNamed:filename];
    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard
{
    [alertMessageTextView resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
//    if (textView == alertMessageTextView)
//    {
//        NSUInteger newLength = (textView.text.length - range.length) + text.length;
//        if(newLength <= 160)
//        {
//            return YES;
//        }
//        else
//        {
//            NSUInteger emptySpace = 160 - (textView.text.length - range.length);
//            textView.text = [[[textView.text substringToIndex:range.location] stringByAppendingString:[text substringToIndex:emptySpace]] stringByAppendingString:[textView.text substringFromIndex:(range.location + range.length)]];
//            return NO;
//        }
//    }
    return YES;
}

- (IBAction)segmentaction:(id)sender {
    if ([sender selectedSegmentIndex]==0)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"alerttolive" sender:self];
            
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"alerttolive" sender:self];
            
        }
    }
    if ([sender selectedSegmentIndex]==1)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self performSegueWithIdentifier:@"alerttohis" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            [self performSegueWithIdentifier:@"alerttohis" sender:self];
            
        }
        
    }
    if ([sender selectedSegmentIndex]==2)
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            // [self performSegueWithIdentifier:@"histoalert" sender:self];
        }
        else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            
            //  [self performSegueWithIdentifier:@"histoalert" sender:self];
            
        }
        
    }
}

-(void)getRouteNumber
{
    NSString *response=[self HttpPostEntityFirst1:@"org_id" ForValue1:orgid  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV" EntityThird:@"vechicle_reg_no" ForValue3:vehicleNo];
   // NSLog(@"Responce : %@",response);
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *parsedvalue = [json objectWithString:response error:&error];
    
   // NSLog(@"%@ lucky numbers",parsedvalue);
    if (parsedvalue == nil)
    {
       // NSLog(@"parsedvalue == nil");
    }
    else
    {
        
        NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
        if ([[menu objectForKey:@"servicename"] isEqualToString:@"Route Number Data"])
        {
            if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
            {
                route_no = [menu objectForKey:@"route_no"];
               // NSLog(@"Geting Route Number : %@",route_no);
            }
            else if ([[menu objectForKey:@"success"] isEqualToString:@"No"])
                
            {
                //invalid username or password
               // NSLog(@"Unable to get route_no details");
            }
            
        }
    }
   // NSLog(@"Got the Route Number and End of getRouteNo method");
    
}
-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"AlertMessageToParents.php?service=select_route_no";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    //NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&password=%@&role=0&%@=%@",firstEntity,value1,password.text,secondEntity,value2];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3,secondEntity,value2];
   // NSLog(@"POST %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    //NSLog(@"Data : %@",[du returndbresult:post URL:url]);
    return [du returndbresult:post URL:url];
}

-(void)getMobileNumbers
{
   // NSLog(@"Get Mobile Numbers method Started");
    NSString *response=[self HttpPostMobileEntityFirst1:@"org_id" ForValue1:orgid  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV" EntityThird:@"pickup_route_no" ForValue3:route_no];
   // NSLog(@"Responce : %@",response);
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *parsedvalue = [json objectWithString:response error:&error];
    
   // NSLog(@"%@ lucky numbers",parsedvalue);
    if (parsedvalue == nil)
    {
       // NSLog(@"parsedvalue == nil");
    }
    else
    {
        
        NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
        if ([[menu objectForKey:@"servicename"] isEqualToString:@"Mobile Number Data"])
        {
            if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
            {
                
                NSArray *arrayNumber = [menu objectForKey:@"Mobile_Number_List"];
                //NSLog(@"array of mobile number is %@",arrayNumber);
                if (arrayNumber.count>0)
                {
                    //NSLog(@"Mobile number is available");
                    for (int i = 0; i < arrayNumber.count; i++)
                    {
                        NSString *number = [[[arrayNumber objectAtIndex:i] objectForKey:@"serviceresponse"] objectForKey:@"mobile_no"];
                        //NSLog(@" Number is %@ ",number);
                        [mobileNumbers addObject:number];
                    }
                }
                else
                {
                  //  NSLog(@"NO Person or student in this Route");
                }
                
            }
            else if ([[menu objectForKey:@"success"] isEqualToString:@"No"])
                
            {
                //invalid username or password
              //  NSLog(@"Unable to get route_no details");
            }
            
        }
    }
    
}
-(NSString *)HttpPostMobileEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"AlertMessageToParents.php?service=select_mobile_numbers";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    //NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&password=%@&role=0&%@=%@",firstEntity,value1,password.text,secondEntity,value2];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3,secondEntity,value2];
  //  NSLog(@"POST %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    //NSLog(@"Data : %@",[du returndbresult:post URL:url]);
    return [du returndbresult:post URL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
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
- (void)dealloc {
    
    
    
    [alertMessageTextView release];
   
 
 
    [super dealloc];
    
}
- (IBAction)sendMessageAction:(UIButton *)sender
{
    NSString *result;
    NSString * username =@"info@holycrossengineeringcollege.com";
    NSString * password = @"tSE4A7qY";
    NSString *textMessage = [alertMessageTextView.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    textMessage = [textMessage stringByReplacingOccurrencesOfString:@"\n" withString:@"%20"];
    
    [sendmessage setEnabled:NO];
    if ([[du submitvalues] isEqualToString:@"Success"])
    {
       // NSLog(@"Network is Rechabile");
        for (int i = 0; i<mobileNumbers.count; i++)
        {
            
            NSString * requestUrl=[NSString stringWithFormat:@"http://api.cutesms.in/sms.aspx?a=submit&un=%@&pw=%@&to=%@&msg=%@",username,password,[mobileNumbers objectAtIndex:i],textMessage];
           NSString *result=  [self send:[NSURL URLWithString:requestUrl]];
            // NSLog(@"response %@",result);
          //  NSLog(@" Mobile Number is : %@ ",[mobileNumbers objectAtIndex:i]);
            if (result)
            {
                if (i == 0)
                {
                    [self.activityIndicator setHidden:NO];
                    [self.activityIndicator startAnimating];
                }
            }
            
        }
        
        [sendmessage setEnabled:YES];
        if ([sendmessage isEnabled])
        {
            [self.activityIndicator stopAnimating];
            [self.activityIndicator setHidden:YES];
            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Message sent successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [self styleCustomAlertView:alertView];
            [self addButtonsWithBackgroundImagesToAlertView:alertView];
            [alertView show];
        }
    }
    else if([[du submitvalues] isEqualToString:@"Failure"])
    {
        [sendmessage setEnabled:YES];
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Message sending failed." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    
    textMessage=@"";
    alertMessageTextView.text=@"";
   
}

-(NSString *)send:(NSURL*)url
{
 
    return [du returndbresult:@"" URL:url];
}
- (IBAction)clearMessageAction:(UIButton *)sender
{
    alertMessageTextView.text = @"";
}
@end
