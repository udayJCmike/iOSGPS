//
//  GPSMobileTrackingViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "GPSMobileTrackingViewController.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "TTAlertView.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface GPSMobileTrackingViewController ()
{
    databaseurl *du;
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
                    [self checkdata];
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
                [HUD hide:YES];
                [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"orgid"] forKey:@"orgid"];
                [[NSUserDefaults standardUserDefaults]setValue:username.text forKey:@"username"];
                 [[NSUserDefaults standardUserDefaults]setValue:[menu objectForKey:@"role"] forKey:@"role"];
                NSLog(@"role %@",[menu objectForKey:@"role"]);
                [[NSUserDefaults standardUserDefaults]synchronize];
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
                con.constant = 244;
            }
            if (con.firstItem == password && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 244;
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
    
    NSString *filename = [du imagecheck:@"login.png"];
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


- (void)dealloc {
 
    [super dealloc];
}
@end
