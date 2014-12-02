//
//  SearchMenu.m
//  DeemGPS
//
//  Created by DeemsysInc on 29/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "SearchMenu.h"

@implementation SearchMenu



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        if (IS_IPAD) {
            greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,768,1024)];
            [greyView setBackgroundColor:[UIColor clearColor]];
            
            
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,768,360)];
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            
            //
            //        CGRect closeButtonFrame=CGRectMake(195, 385, 60, 30);
            //        UIButton *closeButton=[[UIButton alloc]initWithFrame:closeButtonFrame];
            //        [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            //        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
            //        [closeButton.titleLabel setTextColor:[UIColor whiteColor]];
            //        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
            //        [closeButton addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            self.close = [[UIButton alloc]initWithFrame:CGRectMake(203,265,335,44)];
            [self.close addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.close setTitle:@"Cancel" forState:UIControlStateNormal];
            [self.close setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
            [self.close setUserInteractionEnabled:YES];
            [self.close setTintColor:[UIColor whiteColor]];
             self.close.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN Bold" size:19];
            self.close.clipsToBounds=YES;
            self.close.layer.cornerRadius=5;
            
            
            self.search = [[UIButton alloc]initWithFrame:CGRectMake(203,204,335,44)];
            [self.search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
            [self.search setTitle:@"Show" forState:UIControlStateNormal];
            [self.search setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
            [self.search setUserInteractionEnabled:YES];
            [self.search setTintColor:[UIColor whiteColor]];
             self.search.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN Bold" size:19];
            self.search.clipsToBounds=YES;
            self.search.layer.cornerRadius=5;
            
            
            CGRect dateLabelFrame=CGRectMake(251,67,62,21);
            self.Date=[[UILabel alloc]initWithFrame:dateLabelFrame];
            [ self.Date setBackgroundColor:[UIColor clearColor]];
            [ self.Date setText:@"Date :"];
            [ self.Date setTextColor:[UIColor blackColor]];
            [ self.Date setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            
            
            CGRect fromLabelFrame=CGRectMake(251,104,112,21);
            self.fromTime=[[UILabel alloc]initWithFrame:fromLabelFrame];
            [ self.fromTime setBackgroundColor:[UIColor clearColor]];
            [ self.fromTime setText:@"From Time :"];
            [ self.fromTime setTextColor:[UIColor blackColor]];
            [ self.fromTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect toLabelFrame=CGRectMake(251,143,82,21);
            self.toTime=[[UILabel alloc]initWithFrame:toLabelFrame];
            [ self.toTime setBackgroundColor:[UIColor clearColor]];
            [ self.toTime setText:@"To Time :"];
            [ self.toTime setTextColor:[UIColor blackColor]];
            [ self.toTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect dateButtonFrame=CGRectMake(357,63,160,30);
            self.dateButton = [[UIButton alloc]initWithFrame:dateButtonFrame];
            [self.dateButton addTarget:self action:@selector(dateClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.dateButton setTitle:@"Select Date" forState:UIControlStateNormal];
            [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.dateButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:19];
            [self.dateButton setUserInteractionEnabled:YES];
            [self.dateButton setTintColor:[UIColor whiteColor]];
            [self.dateButton setBackgroundColor:[UIColor clearColor]];
            self.dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.dateButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            CGRect fromtimeButtonFrame=CGRectMake(357,100,160,30);
            self.fromButton = [[UIButton alloc]initWithFrame:fromtimeButtonFrame];
            [self.fromButton addTarget:self action:@selector(fromtimeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.fromButton setTitle:@"Select From Time" forState:UIControlStateNormal];
            [self.fromButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.fromButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:19];
            [self.fromButton setUserInteractionEnabled:YES];
            [self.fromButton setTintColor:[UIColor whiteColor]];
            [self.fromButton setBackgroundColor:[UIColor clearColor]];
            self.fromButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.fromButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            
            
            CGRect totimeButtonFrame=CGRectMake(357,139,160,30);
            self.toButton = [[UIButton alloc]initWithFrame:totimeButtonFrame];
            [self.toButton addTarget:self action:@selector(totimeClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.toButton setTitle:@"Select To Time" forState:UIControlStateNormal];
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
        
        
        popUpView  = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,240)];
        [popUpView setBackgroundColor:[UIColor whiteColor]];
        
        
        //
        //        CGRect closeButtonFrame=CGRectMake(195, 385, 60, 30);
        //        UIButton *closeButton=[[UIButton alloc]initWithFrame:closeButtonFrame];
        //        [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        //        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        //        [closeButton.titleLabel setTextColor:[UIColor whiteColor]];
        //        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        //        [closeButton addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        self.close = [[UIButton alloc]initWithFrame:CGRectMake(45,183,230,37)];
        [self.close addTarget:self action:@selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.close setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.close setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
        [self.close setUserInteractionEnabled:YES];
        [self.close setTintColor:[UIColor whiteColor]];
        self.close.clipsToBounds=YES;
        self.close.layer.cornerRadius=5;
        self.close.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN Bold" size:17];
        self.search.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN Bold" size:17];
        
        self.search = [[UIButton alloc]initWithFrame:CGRectMake(45,132,230,37)];
        [self.search addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
        [self.search setTitle:@"Show" forState:UIControlStateNormal];
         [self.search setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forState:UIControlStateNormal];
        [self.search setUserInteractionEnabled:YES];
        [self.search setTintColor:[UIColor whiteColor]];
        self.search.clipsToBounds=YES;
        self.search.layer.cornerRadius=5;

        
        CGRect dateLabelFrame=CGRectMake(45,20,51,26);
        self.Date=[[UILabel alloc]initWithFrame:dateLabelFrame];
        [ self.Date setBackgroundColor:[UIColor clearColor]];
        [ self.Date setText:@"Date :"];
        [ self.Date setTextColor:[UIColor blackColor]];
        [ self.Date setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
      
     
        CGRect fromLabelFrame=CGRectMake(45,61,88,21);
        self.fromTime=[[UILabel alloc]initWithFrame:fromLabelFrame];
        [ self.fromTime setBackgroundColor:[UIColor clearColor]];
        [ self.fromTime setText:@"From Time :"];
        [ self.fromTime setTextColor:[UIColor blackColor]];
        [ self.fromTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect toLabelFrame=CGRectMake(45,97,70,21);
        self.toTime=[[UILabel alloc]initWithFrame:toLabelFrame];
        [ self.toTime setBackgroundColor:[UIColor clearColor]];
        [ self.toTime setText:@"To Time :"];
        [ self.toTime setTextColor:[UIColor blackColor]];
        [ self.toTime setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect dateButtonFrame=CGRectMake(137,19,150,33);
        self.dateButton = [[UIButton alloc]initWithFrame:dateButtonFrame];
        [self.dateButton addTarget:self action:@selector(dateClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.dateButton setTitle:@"Select Date" forState:UIControlStateNormal];
        [self.dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.dateButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:15];
        [self.dateButton setUserInteractionEnabled:YES];
        [self.dateButton setTintColor:[UIColor whiteColor]];
        [self.dateButton setBackgroundColor:[UIColor clearColor]];
        self.dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.dateButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        CGRect fromtimeButtonFrame=CGRectMake(137,58,150,33);
        self.fromButton = [[UIButton alloc]initWithFrame:fromtimeButtonFrame];
        [self.fromButton addTarget:self action:@selector(fromtimeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.fromButton setTitle:@"Select From Time" forState:UIControlStateNormal];
         [self.fromButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.fromButton.titleLabel.font = [UIFont fontWithName:@"Bangla Sangam MN" size:15];
        [self.fromButton setUserInteractionEnabled:YES];
        [self.fromButton setTintColor:[UIColor whiteColor]];
        [self.fromButton setBackgroundColor:[UIColor clearColor]];
        self.fromButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.fromButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        
        CGRect totimeButtonFrame=CGRectMake(137,94,150,33);
        self.toButton = [[UIButton alloc]initWithFrame:totimeButtonFrame];
        [self.toButton addTarget:self action:@selector(totimeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.toButton setTitle:@"Select To Time" forState:UIControlStateNormal];
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
        
        [popUpView addSubview:self.close];
        [popUpView addSubview:self.search];
        [popUpView addSubview:self.Date];
        [popUpView addSubview:self.dateButton];
        [popUpView addSubview:self.fromTime];
        [popUpView addSubview:self.fromButton];
        [popUpView addSubview:self.toTime];
        [popUpView addSubview:self.toButton];
       

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

- (void)drawRect:(CGRect)rect {
    
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
    // Center HUD
//    CGRect allRect = self.bounds;
    // Draw rounded HUD bacgroud rect
//    CGRect boxRect = CGRectMake(roundf((allRect.size.width - 140) / 2) + self.xOffset,
//                                roundf((allRect.size.height - 230) / 2) + self.yOffset, 140, 230);
//    float radius = 5.0f;
//    CGContextBeginPath(context);
//    CGContextSetGrayFillColor(context, 0.0f, 0.9);
//    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
//    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
//    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
//    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
//    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
//    CGContextClosePath(context);
//    CGContextFillPath(context);
}





#pragma mark-Cancel
- (IBAction)cancelButtonSelected:(id)sender
{
  
    //    NSLog(@"DONE BUTTON selected") ;
      [self removeFromSuperview];
   
}

#pragma mark - Search Action _ Date Selection
- (IBAction)dateClicked:(id)sender {
    
    UIButton *but=(UIButton*)sender;
    [but setBackgroundColor:[UIColor grayColor]];
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
        picker.picker.tag=3;
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
        picker.picker.tag=3;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"US"];
    [picker.picker setLocale:locale];
}
#pragma mark - FromTime
- (IBAction)fromtimeClicked:(id)sender {
    UIButton *but=(UIButton*)sender;
    [but setBackgroundColor:[UIColor grayColor]];
    
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
        [picker setMode:UIDatePickerModeTime];
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
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=1;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"UK"];
    [picker.picker setLocale:locale];
    
}


#pragma mark - To time Picker
- (IBAction)totimeClicked:(id)sender {
    UIButton *but=(UIButton*)sender;
    [but setBackgroundColor:[UIColor grayColor]];
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
        [picker setMode:UIDatePickerModeTime];
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
        [picker setMode:UIDatePickerModeTime];
        picker.picker.tag=2;
        [picker.picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"UK"];
    [picker.picker setLocale:locale];
}
-(void)pickerChanged:(id)sender {
    UIDatePicker *dp=(UIDatePicker*)sender;
    //    NSLog(@"time in picker %@",dp.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *timeDate =[dateFormatter1 stringFromDate:[dp date]];
    if (dp.tag==1) {
        self.fromButton.titleLabel.text = timeDate;
          [self.fromButton setBackgroundColor:[UIColor clearColor]];
    }
    else if (dp.tag==2) {
        self.toButton.titleLabel.text  = timeDate;
          [self.toButton setBackgroundColor:[UIColor clearColor]];
    }
    else if (dp.tag==3) {
        self.dateButton.titleLabel.text  = strDate;
           [self.dateButton setBackgroundColor:[UIColor clearColor]];
    }
    
}
#pragma mark - PickerAction

-(void)donePressed {
    UIDatePicker *dp=picker.picker;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate =[dateFormatter stringFromDate:[dp date]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *timeDate =[dateFormatter1 stringFromDate:[dp date]];
    if (dp.tag==1) {
        self.fromButton.titleLabel.text = timeDate;
        [self.fromButton setBackgroundColor:[UIColor clearColor]];
    }
    else if (dp.tag==2) {
        self.toButton.titleLabel.text  = timeDate;
        [self.toButton setBackgroundColor:[UIColor clearColor]];
    }
    else if (dp.tag==3) {
        self.dateButton.titleLabel.text  = strDate;
        [self.dateButton setBackgroundColor:[UIColor clearColor]];
    }
    [picker removeFromSuperview];
    //    NSLog(@"Done button tapped");

    
    
}

-(void)cancelPressed {
//    [self.fromButton setBackgroundColor:[UIColor clearColor]];
//    [self.toButton setBackgroundColor:[UIColor clearColor]];
//    [self.dateButton setBackgroundColor:[UIColor clearColor]];
    [picker removeFromSuperview];
    //    NSLog(@"Cancel pressed");
}
#pragma mark - Date and time comparison
-(BOOL)From_to_dateCheck
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //   NSLocale *indianEnglishLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"] autorelease];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Kolkata"];
    //   [formatter setLocale:indianEnglishLocale];
    //    [formatter setTimeZone:timeZone];
    NSString *fromtime1=[NSString stringWithFormat:@"%@ %@",self.dateButton.titleLabel.text,self.fromButton.titleLabel.text];
    NSString *totime1=[NSString stringWithFormat:@"%@ %@",self.dateButton.titleLabel.text,self.toButton.titleLabel.text];
    NSDate *date1= [formatter dateFromString:fromtime1];
    NSDate *date2 = [formatter dateFromString:totime1];
    NSComparisonResult result = [date1 compare:date2];
    //    NSLog(@"from time %@",date1);
    //     NSLog(@"to time %@",date2);
    //     NSLog(@"result %ld",result);
    if(result == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        return 0;
    }
    else if(result == NSOrderedAscending)
    {
        NSLog(@"date2 is later than date1");
        return 1;
    }
    else
    {
        NSLog(@"date1 is equal to date2");
        return 1;
    }
    return 0;
}

#pragma mark - search Action
- (IBAction)search:(id)sender {
    
    if (![self.dateButton.titleLabel.text isEqualToString:@"Select Date"])
    {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];

        if([self.fromButton.titleLabel.text isEqualToString:@"Select From Time"])
        {
             [dict setValue:@"00:00" forKey:@"Selected_Fromtime"];
            self.fromButton.titleLabel.text=@"00:00";
        }
            if([self.toButton.titleLabel.text isEqualToString:@"Select To Time"])
            {
                [dict setValue:@"23:59" forKey:@"Selected_Totime"];
                self.toButton.titleLabel.text=@"23:59";
            }
       if((![self.fromButton.titleLabel.text isEqualToString:@"Select From Time"])&&(![self.toButton.titleLabel.text isEqualToString:@"Select To Time"]))
       {
           BOOL res= [self From_to_dateCheck];
           if (res)
           {
               [dict setValue:self.dateButton.titleLabel.text forKey:@"Selected_Date"];
               [dict setValue:self.fromButton.titleLabel.text forKey:@"Selected_Fromtime"];
               [dict setValue:self.toButton.titleLabel.text forKey:@"Selected_Totime"];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"HistorySearchDone"  object:dict  userInfo:nil];
               
               [self animateDropDown];
           }
           else
           {
               TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"To time must be greater than from time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
               [self styleCustomAlertView:alertView];
               [self addButtonsWithBackgroundImagesToAlertView:alertView];
               [alertView show];
           }
       }
        
        
       
        
        
        
        
        
        
    }
    else if ([self.dateButton.titleLabel.text isEqualToString:@"Select Date"])
    {
        
        TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:@"INFO" message:@"Select date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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





