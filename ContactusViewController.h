//
//  ContactusViewController.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "TTAlertView.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "UITextField+AKNumericFormatter.h"
#import "AKNumericFormatter.h"

@interface ContactusViewController : UIViewController<UITextViewDelegate,MBProgressHUDDelegate,UITextFieldDelegate,TTAlertViewDelegate,SKPSMTPMessageDelegate>

{
    databaseurl *du;
    BOOL isConnect;
    MBProgressHUD *HUD;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UIButton *resetButton;

@property (retain, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (retain, nonatomic) IBOutlet UITextField *lastNameTextField;

@property (retain, nonatomic) IBOutlet UITextField *emailTextField;

@property (retain, nonatomic) IBOutlet UITextField *organizationNameTextField;


@property (retain, nonatomic) IBOutlet UITextField *mobileNumberTextField;

@property (retain, nonatomic) IBOutlet UITextView *addressTextView;

@property (retain, nonatomic) IBOutlet UITextField *cityTextField;

@property (retain, nonatomic) IBOutlet UITextField *stateTextField;

- (IBAction)addContactToDB:(UIButton *)sender;

- (IBAction)resetButtonAction:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UIButton *sendmessage;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *fname_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *lname_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *email_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *oname_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *mobile_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *text_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *city_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *state_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *send_height;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *reset_height;



@end
