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
        [self performSegueWithIdentifier:@"alerttolive" sender:self];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"alerttolive" sender:self];
        
    }
    
}

- (void)HistoryTapped {
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self performSegueWithIdentifier:@"alerttohis" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        [self performSegueWithIdentifier:@"alerttohis" sender:self];
        
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
       // [self performSegueWithIdentifier:@"thefttospeed" sender:self];
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
     //   [self performSegueWithIdentifier:@"thefttospeed" sender:self];
        
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.activityIndicator.hidden=YES;
     self.navigationController.topViewController.title=@"Alert Message";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIButton* back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UIBarButtonItem *button11 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = button11;
    
    UIBarButtonItem *b= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu_Icon.png"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(toolButtonTapped:)];
    
    //Right BAr Button Items...
    
    
    UIButton* homeButton;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
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
