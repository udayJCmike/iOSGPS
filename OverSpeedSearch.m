//
//  OverSpeedSearch.m
//  DeemGPS
//
//  Created by DeemsysInc on 29/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "OverSpeedSearch.h"

@implementation OverSpeedSearch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        if (IS_IPAD) {
            greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,768,1024)];
            [greyView setBackgroundColor:[UIColor clearColor]];
            
            
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,768,71)];
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            
         
            
            
            self.search = [[UIButton alloc]initWithFrame:CGRectMake(551,16,104,39)];
            [self.search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
            [self.search setTitle:@"Show" forState:UIControlStateNormal];
            [self.search setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
            [self.search setUserInteractionEnabled:YES];
            [self.search setTintColor:[UIColor whiteColor]];
            self.search.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:19];
            self.search.clipsToBounds=YES;
            self.search.layer.cornerRadius=5;
            
            
            CGRect fromLabelFrame=CGRectMake(98,19,130,30);
            self.fromTime=[[UILabel alloc]initWithFrame:fromLabelFrame];
            [ self.fromTime setBackgroundColor:[UIColor clearColor]];
            [ self.fromTime setText:@"From Date"];
            [ self.fromTime setTextColor:[UIColor blackColor]];
            [ self.fromTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect toLabelFrame=CGRectMake(319,19,130,30);
            self.toTime=[[UILabel alloc]initWithFrame:toLabelFrame];
            [ self.toTime setBackgroundColor:[UIColor clearColor]];
            [ self.toTime setText:@"To Date"];
            [ self.toTime setTextColor:[UIColor blackColor]];
            [ self.toTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect fromtimeButtonFrame=CGRectMake(98,19,130,30);
            self.fromButton = [[UIButton alloc]initWithFrame:fromtimeButtonFrame];
            [self.fromButton addTarget:self action:@selector(frombuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
           // [self.fromButton setTitle:@"Select From Time" forState:UIControlStateNormal];
            [self.fromButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.fromButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:19];
            [self.fromButton setUserInteractionEnabled:YES];
            [self.fromButton setTintColor:[UIColor whiteColor]];
            [self.fromButton setBackgroundColor:[UIColor clearColor]];
            self.fromButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.fromButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            
            CGRect totimeButtonFrame=CGRectMake(319,19,130,30);
            self.toButton = [[UIButton alloc]initWithFrame:totimeButtonFrame];
            [self.toButton addTarget:self action:@selector(tobuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
           // [self.toButton setTitle:@"Select To Time" forState:UIControlStateNormal];
            [self.toButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.toButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:19];
            [self.toButton setUserInteractionEnabled:YES];
            [self.toButton setTintColor:[UIColor whiteColor]];
            [self.toButton setBackgroundColor:[UIColor clearColor]];
            self.toButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.toButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
        }
        else if(SCREEN_40)
        {
            
            
            greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,320,568)];
            [greyView setBackgroundColor:[UIColor clearColor]];
            
            
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,71)];
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            
        
            self.search.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:15];
            
            self.search = [[UIButton alloc]initWithFrame:CGRectMake(252,16,58,40)];
            [self.search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
            [self.search setTitle:@"Show" forState:UIControlStateNormal];
            [self.search setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
            [self.search setUserInteractionEnabled:YES];
            [self.search setTintColor:[UIColor whiteColor]];
            self.search.clipsToBounds=YES;
            self.search.layer.cornerRadius=5;
            
            
            CGRect fromLabelFrame=CGRectMake(3,21,120,33);
            self.fromTime=[[UILabel alloc]initWithFrame:fromLabelFrame];
            [ self.fromTime setBackgroundColor:[UIColor clearColor]];
            [ self.fromTime setText:@"From Date"];
            [ self.fromTime setTextColor:[UIColor blackColor]];
            [ self.fromTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect toLabelFrame=CGRectMake(128,21,120,33);
            self.toTime=[[UILabel alloc]initWithFrame:toLabelFrame];
            [ self.toTime setBackgroundColor:[UIColor clearColor]];
            [ self.toTime setText:@"To Date"];
            [ self.toTime setTextColor:[UIColor blackColor]];
            [ self.toTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect fromtimeButtonFrame=CGRectMake(3,21,120,33);
            self.fromButton = [[UIButton alloc]initWithFrame:fromtimeButtonFrame];
            [self.fromButton addTarget:self action:@selector(frombuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
          //  [self.fromButton setTitle:@"From Date" forState:UIControlStateNormal];
            [self.fromButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.fromButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:15];
            [self.fromButton setUserInteractionEnabled:YES];
            [self.fromButton setTintColor:[UIColor whiteColor]];
            [self.fromButton setBackgroundColor:[UIColor clearColor]];
            self.fromButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.fromButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
           
            
            CGRect totimeButtonFrame=CGRectMake(128,21,120,33);
            self.toButton = [[UIButton alloc]initWithFrame:totimeButtonFrame];
            [self.toButton addTarget:self action:@selector(tobuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
           // [self.toButton setTitle:@"To Date" forState:UIControlStateNormal];
            [self.toButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.toButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:15];
            [self.toButton setUserInteractionEnabled:YES];
            [self.toButton setTintColor:[UIColor whiteColor]];
            [self.toButton setBackgroundColor:[UIColor clearColor]];
            self.toButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.toButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
          
            
        }
        self.  handleHeight = 15.0f;
        self. animationDuration = 0.3f;
        self. topMarginPortrait = 0;
        self. topMarginLandscape = 0;
        self. cellFont = [UIFont fontWithName:@"GillSans-Bold" size:19.0f];
        self.fullyOpen=NO;
        
        [popUpView addSubview:self.search];
        [popUpView addSubview:self.fromTime];
     
        [popUpView addSubview:self.toTime];
        
        [popUpView addSubview:self.toButton];
        [popUpView addSubview:self.fromButton];
        [greyView addSubview:popUpView];
        
        //
        //        [UIView beginAnimations:@"curlup" context:nil];
        //        [UIView setAnimationDelegate:self];
        //        [UIView setAnimationDuration:.5];
        //        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft  forView:greyView cache:YES];
        //        //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp  forView:greyView cache:YES];
        //
        //        [UIView commitAnimations];
        //
        //        UIColor *color = [UIColor clearColor];
        //        self.backgroundColor = color;
        [self addSubview:greyView];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        [self animateDropDown];
        
    }
    return self;
}
- (void)animateDropDown
{
    
    
    [UIView animateWithDuration: 0.7
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (self.fullyOpen)
                         {
                             
                             self.center = CGPointMake(self.frame.size.width / 2, -((self.frame.size.height / 2)+63 ));
                             self. fullyOpen = NO;
                         }
                         else
                         {
                             self.center = CGPointMake(self.frame.size.width / 2, ((self.frame.size.height / 2)+63 ));
                             self.fullyOpen = YES;
                         }
                     }
                     completion:^(BOOL finished){
                         //  [delegate pullDownAnimated:fullyOpen];
                     }];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

/*- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //Gradient colours
    size_t gradLocationsNum = 2;
    CGFloat gradLocations[2] = {0.0f, 1.0f};
    CGFloat gradColors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
    CGColorSpaceRelease(colorSpace);
    //Gradient center
    CGPoint gradCenter= CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    //Gradient radius
    float gradRadius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    //Gradient draw
    CGContextDrawRadialGradient (context, gradient, gradCenter,
                                 0, gradCenter, gradRadius,
                                 kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    
    self.xOffset = 0.0f;
    self.yOffset = 0.0f;
    
}*/





#pragma mark-Cancel
- (IBAction)cancelButtonSelected:(id)sender
{
    
    //    NSLog(@"DONE BUTTON selected") ;
    [self removeFromSuperview];
    
}

#pragma mark -From Date Selection
- (IBAction)frombuttonClicked:(id)sender {
   
    [self.fromTime setBackgroundColor:[UIColor grayColor]];
    
    [self cancelPressed];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0,(screenHeight-290), screenWidth, screenHeight/2 + 35)];
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self addSubview:picker];
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
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+50, screenWidth, screenHeight/2 + 35)];
        if(SCREEN_35)
        {
            picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+20, screenWidth, screenHeight/2 + 35)];
        }
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self addSubview:picker];
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
        self.fromTime.text = strDate;
         [self.fromTime setBackgroundColor:[UIColor clearColor]];
    }
    else if (dp.tag==2) {
        self.toTime.text = strDate;
         [self.toTime setBackgroundColor:[UIColor clearColor]];
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
        self.fromTime.text = strDate;
        [self.fromTime setBackgroundColor:[UIColor clearColor]];
       
    }
    else if (dp.tag==2) {
        self.toTime.text = strDate;
         [self.toTime setBackgroundColor:[UIColor clearColor]];
    }
    [picker removeFromSuperview];
    //    NSLog(@"Done button tapped");
    
}

-(void)cancelPressed {
    [picker removeFromSuperview];
    //    NSLog(@"Cancel pressed");
}
#pragma mark -To Date Selection

- (IBAction)tobuttonClicked:(id)sender {
  
    [self.toTime setBackgroundColor:[UIColor grayColor]];
    [self cancelPressed];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0,screenHeight-290, screenWidth, screenHeight/2 + 35)];
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self addSubview:picker];
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
        picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+50, screenWidth, screenHeight/2 + 35)];
        if(SCREEN_35)
        {
            picker = [[DateTimePicker alloc] initWithFrame:CGRectMake(0, screenHeight/2+20, screenWidth, screenHeight/2 + 35)];
        }
        [picker addTargetForDoneButton:self action:@selector(donePressed)];
        [picker addTargetForCancelButton:self action:@selector(cancelPressed)];
        [self addSubview:picker];
        picker.hidden = NO;
        [picker setMode:UIDatePickerModeDate];
        picker.picker.tag=2;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
}
-(BOOL)From_to_dateCheck
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //   NSLocale *indianEnglishLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"] autorelease];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
    //   [formatter setLocale:indianEnglishLocale];
    //    [formatter setTimeZone:timeZone];
    NSString *fromtime1=self.fromTime.text;
    NSString *totime1=self.toTime.text;
    NSDate *date1= [formatter dateFromString:fromtime1];
    NSDate *date2 = [formatter dateFromString:totime1];
    NSComparisonResult result = [date1 compare:date2];
    //       NSLog(@"from time %@",date1);
    //         NSLog(@"to time %@",date2);
    //         NSLog(@"result %ld",result);
    if(result == NSOrderedDescending)
    {
//        NSLog(@"date1 is later than date2");
        return 0;
    }
    else if(result == NSOrderedAscending)
    {
//        NSLog(@"date2 is later than date1");
        return 1;
    }
    else
    {
//        NSLog(@"date1 is equal to date2");
        return 1;
    }
    return 0;
}

#pragma mark -Search Action

- (IBAction)search:(id)sender {
    
    if ((![self.fromTime.text isEqualToString:@"From Date"])&&(![self.toTime.text isEqualToString:@"To Date"])) {
        BOOL res= [self From_to_dateCheck];
        if (res)
        {
            NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];           
            [dict setValue:self.fromTime.text forKey:@"Selected_FromDate"];
            [dict setValue:self.toTime.text forKey:@"Selected_ToDate"];
            [self animateDropDown];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchDone"  object:dict  userInfo:nil];
        }
        else
        {
            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"To date must be greater than from date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [self styleCustomAlertView:alertView];
            [self addButtonsWithBackgroundImagesToAlertView:alertView];
            [alertView show];
        }
        
        
    }
    else if ([self.fromTime.text isEqualToString:@"From Date"])
    {
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select from date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    else if ([self.toTime.text isEqualToString:@"To Date"])
    {
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select to date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [self styleCustomAlertView:alertView];
        [self addButtonsWithBackgroundImagesToAlertView:alertView];
        [alertView show];
    }
    
}
#pragma mark - CustomPicker
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

- (void)dealloc {
    
    [super dealloc];
}
@end






