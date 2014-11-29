//
//  InformationVC.m
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "InformationVC.h"

@implementation InformationVC

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,320,568)];
         [greyView setBackgroundColor:[UIColor clearColor]];
        
        
        popUpView  = [[UIView alloc] initWithFrame:CGRectMake(19,73,282,471)];
        [popUpView setBackgroundColor:[UIColor whiteColor]];
    
        
//       
//        CGRect closeButtonFrame=CGRectMake(195, 385, 60, 30);
//        UIButton *closeButton=[[UIButton alloc]initWithFrame:closeButtonFrame];
//        [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
//        [closeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
//        [closeButton.titleLabel setTextColor:[UIColor whiteColor]];
//        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
//        [closeButton addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

        
       
         self.close = [[UIButton alloc]initWithFrame:CGRectMake(5,9,70,30)];
        [self.close addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self.close setTitle:@"Done" forState:UIControlStateNormal];
        [self.close setUserInteractionEnabled:YES];
        [self.close setTintColor:[UIColor whiteColor]];
        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem.width = -16;
        
       
        UIBarButtonItem *item11=[[UIBarButtonItem alloc]initWithCustomView:self.close];
        UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 282, 44)];
        UINavigationItem *item=[[UINavigationItem alloc]initWithTitle:@"Live Information"];
        navbar.items=[NSArray arrayWithObjects:item,nil];
       navbar.topItem.rightBarButtonItems=@[fixedItem,item11,fixedItem,fixedItem];
       // [navbar addSubview:v3];
        
         CGRect countLabelFrame=CGRectMake(123,100,45,44);
        self.countDown=[[UILabel alloc]initWithFrame:countLabelFrame];
        [ self.countDown setBackgroundColor:[UIColor clearColor]];
        [ self.countDown setText:@"00"];
        [ self.countDown setTextColor:[UIColor blackColor]];
        [ self.countDown setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:25]];
        
        
         UIView *v1  = [[UIView alloc] initWithFrame:CGRectMake(4,185,274,71)];
        v1.clipsToBounds=YES;
        v1.layer.cornerRadius=10;
        [v1 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
        CGRect vecRegFrame=CGRectMake(7,14,124,21);
        self.vecreg=[[UILabel alloc]initWithFrame:vecRegFrame];
        [ self.vecreg setBackgroundColor:[UIColor clearColor]];
        [ self.vecreg setText:@"Vehicle Reg.No:"];
        [ self.vecreg setTextColor:[UIColor blackColor]];
        [ self.vecreg setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect vecRegansFrame=CGRectMake(120,14,144,21);
        self.vecreg_ans=[[UILabel alloc]initWithFrame:vecRegansFrame];
        [ self.vecreg_ans setBackgroundColor:[UIColor clearColor]];
        [ self.vecreg_ans setText:@"TN0942358"];
        [ self.vecreg_ans setTextColor:[UIColor blackColor]];
        [ self.vecreg_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect OwnerNameFrame=CGRectMake(7,45,107,21);
        self.ownername=[[UILabel alloc]initWithFrame:OwnerNameFrame];
        [ self.ownername setBackgroundColor:[UIColor clearColor]];
        [ self.ownername setText:@"Driver Name:"];
        [ self.ownername setTextColor:[UIColor blackColor]];
        [ self.ownername setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect OwnerNameansFrame=CGRectMake(120,45,194,21);
        self.ownername_ans=[[UILabel alloc]initWithFrame:OwnerNameansFrame];
        [ self.ownername_ans setBackgroundColor:[UIColor clearColor]];
        [ self.ownername_ans setText:@"John"];
        [ self.ownername_ans setTextColor:[UIColor blackColor]];
        [ self.ownername_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
     
        UIView *v2  = [[UIView alloc] initWithFrame:CGRectMake(4,258,274,209)];
        [v2 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
        
        CGRect indiimage=CGRectMake(0,2,274,41);
        self.indi_bg=[[UIImageView alloc]initWithFrame:indiimage];
        [ self.indi_bg setImage:[UIImage imageNamed:@"Navbarbg.jpg"]];
        
        CGRect InsFrame=CGRectMake(69,12,145,21);
        self.instruction=[[UILabel alloc]initWithFrame:InsFrame];
        [ self.instruction setBackgroundColor:[UIColor clearColor]];
        [ self.instruction setText:@"Indicator Details"];
        [ self.instruction setTextColor:[UIColor whiteColor]];
        [ self.instruction setFont:[UIFont fontWithName:@"Bangla Sangam MN Bold" size:17.0]];
        
        
        CGRect redimgFrame=CGRectMake(69,70,25,25);
        self.red=[[UIImageView alloc]initWithFrame:redimgFrame];
        [ self.red setImage:[UIImage imageNamed:@"red_pin.png"]];
        
        CGRect greenimgFrame=CGRectMake(69,103,25,25);
        self.green=[[UIImageView alloc]initWithFrame:greenimgFrame];
        [ self.green setImage:[UIImage imageNamed:@"green_pin.png"]];
        
        CGRect pinkimgFrame=CGRectMake(69,136,25,25);
        self.pink=[[UIImageView alloc]initWithFrame:pinkimgFrame];
        [ self.pink setImage:[UIImage imageNamed:@"pink_pin.png"]];
        
        
        CGRect redansFrame=CGRectMake(98,72,115,21);
        self.red_lab=[[UILabel alloc]initWithFrame:redansFrame];
        [ self.red_lab setBackgroundColor:[UIColor clearColor]];
        [ self.red_lab setText:@"Last Location"];
        [ self.red_lab setTextColor:[UIColor blackColor]];
        [ self.red_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        
        CGRect greenansFrame=CGRectMake(98,105,125,21);
        self.green_lab=[[UILabel alloc]initWithFrame:greenansFrame];
        [ self.green_lab setBackgroundColor:[UIColor clearColor]];
        [ self.green_lab setText:@"Current Location"];
        [ self.green_lab setTextColor:[UIColor blackColor]];
        [ self.green_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        CGRect pinkansFrame=CGRectMake(98,138,163,21);
        self.pink_lab=[[UILabel alloc]initWithFrame:pinkansFrame];
        [ self.pink_lab setBackgroundColor:[UIColor clearColor]];
        [ self.pink_lab setText:@"Overspeed Location"];
        [ self.pink_lab setTextColor:[UIColor blackColor]];
        [ self.pink_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
        
        
        
       
        [v1 addSubview:self.vecreg];
        [v1 addSubview:self.vecreg_ans];
        [v1 addSubview:self.ownername];
        [v1 addSubview:self.ownername_ans];
         [v2 addSubview:self.indi_bg];
        [v2 addSubview:self.instruction];
        [v2 addSubview:self.red];
        [v2 addSubview:self.red_lab];
        [v2 addSubview:self.green];
        [v2 addSubview:self.green_lab];
        [v2 addSubview:self.pink];
        [v2 addSubview:self.pink_lab];
        [popUpView addSubview:navbar];
       
        
       
         NSDate *TickTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"];
        NSDate *startTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"];
        interval=[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue];
//        NSLog(@"tick date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"]);
//        NSLog(@"start date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"]);
//        NSLog(@"tick count in popover %d",[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue]);
        NSDate *endTime=[TickTime dateByAddingTimeInterval:interval];
//        NSLog(@"End date in popover %@",endTime);
        
        self.initialDate=startTime;
        self.finalDate=endTime;
        
        
            self.radius=60;
            self.internalRadius=30;
            self.circleStrokeColor=[UIColor grayColor];
            self.activeCircleStrokeColor=[UIColor colorWithRed:15/255.0 green:164/255.0 blue:225/255.0 alpha:1.0] ;
          [self createCircle];
        
        [popUpView addSubview:self.countDown];
        
        [popUpView addSubview:v1];
        [popUpView addSubview:v2];
      // [popUpView addSubview:v3];
      
        [popUpView addSubview:navbar];
        [greyView addSubview:popUpView];
        [UIView beginAnimations:@"curlup" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft  forView:greyView cache:YES];
     //    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp  forView:greyView cache:YES];
        [self addSubview:greyView];
        [UIView commitAnimations];
        
        UIColor *color = [UIColor clearColor];
        self.backgroundColor = color;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        
    }
    return self;
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
// CGRect allRect = self.bounds;
// // Draw rounded HUD bacgroud rect
// CGRect boxRect = CGRectMake(roundf((allRect.size.width - 140) / 2) + self.xOffset,
// roundf((allRect.size.height - 230) / 2) + self.yOffset, 140, 230);
// float radius = 5.0f;
// CGContextBeginPath(context);
// CGContextSetGrayFillColor(context, 0.0f, 0.9);
// CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
// CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
// CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
// CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
// CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
// CGContextClosePath(context);
// CGContextFillPath(context);
 }



-(void)answerDoubleTapped:(UIGestureRecognizer*)sender
{
    [greyView removeFromSuperview];
}



- (IBAction)doneButtonSelected:(id)sender
{
//    NSLog(@"DONE BUTTON selected") ;
    self.circularTimer = nil;
    [self.circularTimer removeFromSuperview];
    [CountDownTimer invalidate];
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveView"  object:self  userInfo:nil];
}



-(void)restartCircle
{
    NSDate *endTime=[[NSDate date] dateByAddingTimeInterval:30];
    self.circularTimer.initialDate=[NSDate date];
    self.circularTimer.finalDate=endTime;
    TotalSec=30;
    
    
    
    [self.circularTimer setup];
    
    
}
- (void)createCircle
{
    self.circularTimer = [[CircularTimer alloc] initWithPosition:CGPointMake(78.0f, 55.0f)
                                                          radius:self.radius
                                                  internalRadius:self.internalRadius
                                               circleStrokeColor:self.circleStrokeColor
                                         activeCircleStrokeColor:self.activeCircleStrokeColor
                                                     initialDate:self.initialDate
                                                       finalDate:self.finalDate
                                                   startCallback:^{
                                                      // NSLog(@"Running!");
                                                   }
                                                     endCallback:^{
                                                         [self restartCircle];
                                                         
                                                     }];
    if ([self.circularTimer willRun]){
        self.countDown.text=[NSString stringWithFormat:@"%02d",interval-1];
        
        if (!CountDownTimer) {
            
            CountDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(UpdateCountDown:)
                                                            userInfo:nil
                                                             repeats:YES];
            TotalSec=interval-1;
        }
        
    }
    else
    {
        self.countDown.text=[NSString stringWithFormat:@"00"];
    }
  //  NSLog(([self.circularTimer willRun]) ? @"Circle will run" : @"Circle won't run");
    
    [popUpView addSubview:self.circularTimer];
}



-(void)UpdateCountDown:(NSTimer*)theTimer
{
    if (TotalSec>1) {
        TotalSec--;
        self.countDown.text=[NSString stringWithFormat:@"%02d",TotalSec];
    }
    else if(TotalSec==1)
    {
        self.countDown.text=[NSString stringWithFormat:@"00"];
        TotalSec=30;
        [self.circularTimer completeRun];
    }
    
}


- (void)dealloc {
    [_countDown release];
    [super dealloc];
}
@end


