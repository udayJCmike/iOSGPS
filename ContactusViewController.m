//
//  ContactusViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "ContactusViewController.h"
#import "TTAlertView.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface ContactusViewController ()

@end

@implementation ContactusViewController
int c;
int i;
int message_count;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize emailTextField;
@synthesize organizationNameTextField;
@synthesize mobileNumberTextField;
@synthesize addressTextView;
@synthesize cityTextField;
@synthesize stateTextField;
@synthesize imageView;
@synthesize sendmessage;
@synthesize resetButton;
@synthesize fname_height;
@synthesize lname_height;
@synthesize email_height;
@synthesize oname_height;
@synthesize mobile_height;
@synthesize text_height;
@synthesize city_height;
@synthesize state_height;
@synthesize reset_height;
@synthesize send_height;
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
    message_count=0;
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == firstNameTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 169;
                self.fname_height.constant=25;
            }
            if (con.firstItem == lastNameTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 201;
                self.lname_height.constant=25;
            }
            if (con.firstItem == emailTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 233;
                self.email_height.constant=25;
            }
            if (con.firstItem == organizationNameTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =265;
                self.oname_height.constant=25;
            }
            if (con.firstItem == mobileNumberTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 297;
                self.mobile_height.constant=25;
                
            }
            if (con.firstItem == addressTextView && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =329;
                self.text_height.constant=43;
            }
            if (con.firstItem == cityTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =380;
                self.city_height.constant=25;
                
            }
            if (con.firstItem == stateTextField && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 412;
                self.state_height.constant=25;
            }
            if (con.firstItem == sendmessage && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 440;
                send_height.constant=25;
            }
            if (con.firstItem == resetButton && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 440;
                reset_height.constant=25;
               
            }
            
            
        }
    }

    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    AKNumericFormatterMode mode = AKNumericFormatterMixed;
    mobileNumberTextField.numericFormatter = [AKNumericFormatter formatterWithMask:@"(***)***-****" placeholderCharacter:'*'mode:mode];

    // Do any additional setup after loading the view.
    du=[[databaseurl alloc]init];
    addressTextView.delegate=self;
    mobileNumberTextField.delegate = self;
    firstNameTextField.delegate = self;
    lastNameTextField.delegate=self;
    organizationNameTextField.delegate = self;
    cityTextField.delegate = self;
    stateTextField.delegate = self;
    emailTextField.delegate=self;
    
    addressTextView.layer.borderWidth = 0.5;
    addressTextView.layer.cornerRadius = 5;
    addressTextView.clipsToBounds = YES;
    addressTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    i = 0;
    NSString *filename = [du imagecheck:@"contact.jpg"];
    NSLog(@"image name %@",filename);
    imageView.image = [UIImage imageNamed:filename];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    for (UIView *v in [self.view subviews]) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *textfield=(UITextField*)v;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)dismissKeyboard
{
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [organizationNameTextField resignFirstResponder];
    [mobileNumberTextField resignFirstResponder];
    [addressTextView resignFirstResponder];
    [cityTextField resignFirstResponder];
    [stateTextField resignFirstResponder];
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

- (void)dealloc {
    [addressTextView release];
    [firstNameTextField release];
    [lastNameTextField release];
    [emailTextField release];
    [mobileNumberTextField release];
    [cityTextField release];
    [stateTextField release];
    [organizationNameTextField release];
    [resetButton release];
    [imageView release];
   
    [super dealloc];
}
- (IBAction)addContactToDB:(UIButton *)sender
{
    [self dismissKeyboard];
    if ([addressTextView.text isEqualToString:@"Address"])
    {
        addressTextView.text = @"";
    }
    if (firstNameTextField.text.length>0 &&
        lastNameTextField.text.length>0 &&
        emailTextField.text.length>0 &&
        organizationNameTextField.text.length>0 &&
        mobileNumberTextField.text.length>0 &&
        addressTextView.text.length>0 &&
        cityTextField.text.length>0 &&
        stateTextField.text.length>0)
    {
        if ([du validateNameForContactUsPage:firstNameTextField.text])
        {
            if ([du validateNameForContactUsPage:lastNameTextField.text])
            {
                if ([du validateEmailForContactUsPage:emailTextField.text])
                {
                    if ([du validateOtherNameForContactUsPage:organizationNameTextField.text])
                    {
                        if ([du validateMobileForContactUsPage:mobileNumberTextField.text])
                        {
                            if ([addressTextView.text length]>0)
                            {
                                if ([du validateOtherNameForContactUsPage:cityTextField.text])
                                {
                                    if ([du validateOtherNameForContactUsPage:stateTextField.text])
                                    {
                                        c = 1;
                                    }
                                    else
                                    {
                                        c = 0;
                                        // enter state TextField
                                       // NSLog(@"ENTER VALID STATE NAME");
                                        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid state" message:@"State should contain only alphabets" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                        [self styleCustomAlertView:alertView];
                                        [self addButtonsWithBackgroundImagesToAlertView:alertView];
                                        [alertView show];
                                    }
                                }
                                else
                                {
                                    c = 0;
                                    // enter city TextField
                                  //  NSLog(@"ENTER VALID CITY NAME");
                                    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid city" message:@"City should contain only alphabets" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                    [self styleCustomAlertView:alertView];
                                    [self addButtonsWithBackgroundImagesToAlertView:alertView];
                                    [alertView show];
                                }
                            }
                            else
                            {
                                c = 0;
                                // enter address Textview
                              //  NSLog(@"PLEASE ENTER ADDRESS");
                                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid address" message:@"Address should contain only alphabets." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                [self styleCustomAlertView:alertView];
                                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                                [alertView show];
                                [addressTextView setTextColor:[UIColor lightGrayColor]];
                                i = 0;
                                addressTextView.text=@"Address";
                            }
                        }
                        else
                        {
                            c = 0;
                            // enter mobile TextField
                          //  NSLog(@"ENTER VALID MOBILE NUMBER");
                            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid mobile number" message:@"Mobile number should contain only numbers." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                            [self styleCustomAlertView:alertView];
                            [self addButtonsWithBackgroundImagesToAlertView:alertView];
                            [alertView show];
                        }
                    }
                    else
                    {
                        c = 0;
                        // enter organization TextField
                      //  NSLog(@"ENTER VALID ORGANIZATION NAME");
                        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid organization name" message:@"Organization name should contain only alphabets." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [self styleCustomAlertView:alertView];
                        [self addButtonsWithBackgroundImagesToAlertView:alertView];
                        [alertView show];
                    }
                }
                else
                {
                    c = 0;
                    // enter email TextField
                 //   NSLog(@"ENTER VALID EMAIL-ID");
                    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid email" message:@"Email should contain only alphabets,numbers,@ . _" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [self styleCustomAlertView:alertView];
                    [self addButtonsWithBackgroundImagesToAlertView:alertView];
                    [alertView show];
                }
            }
            else
            {
                c=0;
                //enter lastname TextField
              //  NSLog(@"ENTER VALID LAST NAME");
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid lastname" message:@"Lastname should contain only alphabets,4-16 characters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
        }
        else
        {
            c=0;
            //enter firstname TextField
          //  NSLog(@"ENTER VALID FIRST NAME");
            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"Invalid firstname" message:@"Firstname should contain only alphabets,4-16 characters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [self styleCustomAlertView:alertView];
            [self addButtonsWithBackgroundImagesToAlertView:alertView];
            [alertView show];
        }
    }
    else
    {
        c=0;
        //enter all required fields
     //   NSLog(@"ENTER ALL REQUIRED FIELDS");
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Please enter all fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
        if (addressTextView.text.length<1)
        {
            [addressTextView setTextColor:[UIColor lightGrayColor]];
            i = 0;
            addressTextView.text=@"Address";
        }
    }
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

-(void)checkdata
{
    NSString *response=[self HttpPostEntityFirst1:@"firstname" ForValue1:firstNameTextField.text  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
 //   NSLog(@"Responce : %@",response);
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *parsedvalue = [json objectWithString:response error:&error];
    
  //  NSLog(@"%@ lucky numbers",parsedvalue);
    if (parsedvalue == nil)
    {
        //NSLog(@"parsedvalue == nil");
        [HUD hide:YES];
    }
    else
    {
        
        NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
        if ([[menu objectForKey:@"servicename"] isEqualToString:@"Contact Us Data"])
        {
            if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
            {
               
               // NSLog(@"Inserting Contact Details Succecssful");
                [self sendEmailInBackground];
                [self sendEmailInBackgroundToSuperAdmin];
               
               
                //                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                //                {
                //                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPad" bundle:nil];
                //                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                //                    [self.navigationController pushViewController:initialvc animated:YES];
                //                }
                //                if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
                //                {
                //                    UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPhone" bundle:nil];
                //                    UIViewController *initialvc=[welcome instantiateInitialViewController];
                //                    [self.navigationController pushViewController:initialvc animated:YES];
                //                }
            }
            else if ([[menu objectForKey:@"success"] isEqualToString:@"No"])
                
            {
                [HUD hide:YES];
                //invalid username or password
              //  NSLog(@"Failed to insert Contact Details");
                TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Can't reach server." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [self styleCustomAlertView:alertView];
                [self addButtonsWithBackgroundImagesToAlertView:alertView];
                [alertView show];
            }
            
        }
    }
    
}
-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
    NSString *url1=@"ContactUs.php?service=contact_insert";
    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
    //NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&password=%@&role=0&%@=%@",firstEntity,value1,password.text,secondEntity,value2];
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&lastname=%@&email=%@&organisation=%@&mobile=%@&address1=%@&city=%@&state=%@&%@=%@",firstEntity,value1,lastNameTextField.text,emailTextField.text,organizationNameTextField.text,mobileNumberTextField.text,addressTextView.text,cityTextField.text,stateTextField.text,secondEntity,value2];
  //  NSLog(@"POST %@",post);
    NSURL *url = [NSURL URLWithString:url2];
    return [du returndbresult:post URL:url];
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [addressTextView setTextColor:[UIColor blackColor]];
    if (i == 0)
    {
        addressTextView.text=@"";
        i++;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text length]<1)
    {
      //  NSLog(@" Text View length : %lu",(unsigned long)textView.text.length);
        [addressTextView setTextColor:[UIColor lightGrayColor]];
        i = 0;
        addressTextView.text=@"Address";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == mobileNumberTextField)
    {
        NSString *rangeOfString = @"789";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![string isEqualToString:@""])
        {
            if ((range.location == 0 && ![rangeOfCharacters characterIsMember:[string characterAtIndex:0]]) || (range.location == 1 && ![rangeOfCharacters characterIsMember:[string characterAtIndex:0]]))
            {
                return NO;
            }
        }
        NSUInteger newLength = (textField.text.length - range.length) + string.length;
        if(newLength <= 13)
        {
            return YES;
        }
        else
        {
            NSUInteger emptySpace = 13 - (textField.text.length - range.length);
            textField.text = [[[textField.text substringToIndex:range.location] stringByAppendingString:[string substringToIndex:emptySpace]] stringByAppendingString:[textField.text substringFromIndex:(range.location + range.length)]];
            return NO;
        }
        
        
    }
    else if (textField == organizationNameTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![string isEqualToString:@""])
        {
            if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
            {
                
                return NO;
            }
        }
    }
    else if(textField == cityTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![string isEqualToString:@""])
        {
            if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
            {
                
                return NO;
            }
        }
    }
    else if(textField == stateTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![string isEqualToString:@""])
        {
            if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
            {
                
                return NO;
            }
        }
    }
    else if (textField == firstNameTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
//        for (int i = 0; i<[string length]; i++)
//        {
//            UniChar c1 = [string characterAtIndex:i];
//            if ([rangeOfCharacters characterIsMember:c1])
//            {
//                return NO;
//            }
//        }
        if(![string isEqualToString:@""])
        {
            if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
            {
                
                return NO;
            }
        }

    }
    else if (textField == lastNameTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
//        for (int i = 0; i<[string length]; i++)
//        {
//            UniChar c1 = [string characterAtIndex:i];
//            if ([rangeOfCharacters characterIsMember:c1])
//            {
//                return NO;
//            }
//        }
        if(![string isEqualToString:@""])
        {
            if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
            {
                
                return NO;
            }
        }

    }
    else if(textField == emailTextField)
    {
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![string isEqualToString:@""])
        {
        if (range.location == 0 && [rangeOfCharacters characterIsMember:[string characterAtIndex:0]] )
        {
          
            return NO;
        }
        }
        
    }
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == addressTextView)
    {
       
        NSString *rangeOfString = @" ";
        NSCharacterSet *rangeOfCharacters = [NSCharacterSet characterSetWithCharactersInString:rangeOfString];
        if(![text isEqualToString:@""])
        {
        if (range.location == 0 && [rangeOfCharacters characterIsMember:[text characterAtIndex:0]] )
        {
 
            return NO;
        }
         }
        
    }
    return YES;
}

- (IBAction)resetButtonAction:(UIButton *)sender
{
    [self dismissKeyboard];
    firstNameTextField.text=@"";
    lastNameTextField.text=@"";
    emailTextField.text=@"";
    organizationNameTextField.text=@"";
    mobileNumberTextField.text=@"";
    [addressTextView setTextColor:[UIColor lightGrayColor]];
    i = 0;
    addressTextView.text=@"Address";
    cityTextField.text=@"";
    stateTextField.text=@"";
}

#pragma Sending Mail Automatically in Background

-(void) sendEmailInBackground {
  //  NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"deemgpsapp@gmail.com"; //sender email address
    emailMessage.toEmail = [NSString stringWithFormat:@"%@",emailTextField.text];  //receiver email address
    NSLog(@" TO EMAIL ID IS -- %@",emailMessage.toEmail);
    emailMessage.relayHost = @"smtp.gmail.com";
    //emailMessage.ccEmail =@"your cc address";
    //emailMessage.bccEmail =@"your bcc address";
    emailMessage.requiresAuth = YES;
    emailMessage.login = @"deemgpsapp@gmail.com"; //sender email address
    emailMessage.pass = @"pentagon7"; //sender email password
    emailMessage.subject =@"Acknowledgement";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *messageBody =  [NSString stringWithFormat:@"\n\nHi %@,\n\nThanks for Contacting Us...\nOur Sales & Support team will contact you shortly\n\n",firstNameTextField.text];
    //for example :   NSString *messageBody = [NSString stringWithFormat:@"Tour Name: %@\nName: %@\nEmail: %@\nContact No: %@\nAddress: %@\nNote: %@",selectedTour,nameField.text,emailField.text,foneField.text,addField.text,txtView.text];
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    //in addition : Logic for attaching file with email message.
    /*
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filename" ofType:@"JPG"];
     NSData *fileData = [NSData dataWithContentsOfFile:filePath];
     NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-
     unix-mode=0644;\r\n\tname=\"filename.JPG\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"filename.JPG\"",kSKPSMTPPartContentDispositionKey,[fileData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
     emailMessage.parts = [NSArray arrayWithObjects:plainMsg,fileMsg,nil]; //including plain msg and attached file msg
     */
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}

-(void) sendEmailInBackgroundToSuperAdmin {
  //  NSLog(@"Start Sending");
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"deemgpsapp@gmail.com"; //sender email address
    emailMessage.toEmail = @"udayjc@icloud.com";  //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    //emailMessage.ccEmail =@"your cc address";
    //emailMessage.bccEmail =@"your bcc address";
    emailMessage.requiresAuth = YES;
    emailMessage.login = @"deemgpsapp@gmail.com"; //sender email address
    emailMessage.pass = @"pentagon7"; //sender email password
    emailMessage.subject =@"Contact Us Information";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *messageBody = [NSString stringWithFormat:@"\n\nHi,\n\nBelow are the details of the contacted person\n\nFirstName : %@ \nLastName : %@ \nEmail-ID : %@ \nOrganisation Name : %@ \nMobile Number : %@ \nAddress : %@ \nCity : %@ \nState : %@ \n\n ",firstNameTextField.text,lastNameTextField.text,emailTextField.text,organizationNameTextField.text,mobileNumberTextField.text,addressTextView.text,cityTextField.text,stateTextField.text];
    //for example :   NSString *messageBody = [NSString stringWithFormat:@"Tour Name: %@\nName: %@\nEmail: %@\nContact No: %@\nAddress: %@\nNote: %@",selectedTour,nameField.text,emailField.text,foneField.text,addField.text,txtView.text];
    // Now creating plain text email message
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    //in addition : Logic for attaching file with email message.
    /*
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filename" ofType:@"JPG"];
     NSData *fileData = [NSData dataWithContentsOfFile:filePath];
     NSDictionary *fileMsg = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-
     unix-mode=0644;\r\n\tname=\"filename.JPG\"",kSKPSMTPPartContentTypeKey,@"attachment;\r\n\tfilename=\"filename.JPG\"",kSKPSMTPPartContentDispositionKey,[fileData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
     emailMessage.parts = [NSArray arrayWithObjects:plainMsg,fileMsg,nil]; //including plain msg and attached file msg
     */
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...
}

//Now, handling delegate methods :
// On success

-(void)messageSent:(SKPSMTPMessage *)message{
    message_count++;
    if (message_count==2) {
         [self resetButtonAction:self.resetButton];
        message_count=0;
        [HUD hide:YES];
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Message sent." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    NSLog(@"delegate - message sent");
}
// On Failure
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO!" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [self styleCustomAlertView:alertView];
    [self addButtonsWithBackgroundImagesToAlertView:alertView];
    [alertView show];
    NSLog(@"delegate - error(%d): %@ and %@", [error code], [error localizedDescription],[error localizedRecoverySuggestion]);
}

@end
