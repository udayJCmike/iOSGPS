//
//  HistroytrackInformation.m
//  DeemGPS
//
//  Created by DeemsysInc on 29/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "HistroytrackInformation.h"

@implementation HistroytrackInformation


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        if (IS_IPAD) {
            greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,768,1024)];
            [greyView setBackgroundColor:[UIColor clearColor]];
            
            
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(114,307,540,409)];
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            self.close = [[UIButton alloc]initWithFrame:CGRectMake(5,9,70,30)];
            [self.close addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.close setTitle:@"Done" forState:UIControlStateNormal];
            [self.close setUserInteractionEnabled:YES];
            [self.close setTintColor:[UIColor whiteColor]];
            UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            fixedItem.width = -16;
            
            
            UIBarButtonItem *item11=[[UIBarButtonItem alloc]initWithCustomView:self.close];
           navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0, 540, 44)];
            UINavigationItem *item=[[UINavigationItem alloc]initWithTitle:@"Track Information"];
            navbar.items=[NSArray arrayWithObjects:item,nil];
            navbar.topItem.rightBarButtonItems=@[fixedItem,item11,fixedItem,fixedItem];
            // [navbar addSubview:v3];
            
       
            
            
            v1  = [[UIView alloc] initWithFrame:CGRectMake(10,56,519,144)];
            v1.clipsToBounds=YES;
            v1.layer.cornerRadius=10;
            [v1 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
            CGRect vecRegFrame=CGRectMake(91,20,155,21);
            self.vecreg=[[UILabel alloc]initWithFrame:vecRegFrame];
            [ self.vecreg setBackgroundColor:[UIColor clearColor]];
            [ self.vecreg setText:@"Vehicle Reg.No:"];
            [ self.vecreg setTextColor:[UIColor blackColor]];
            [ self.vecreg setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect vecRegansFrame=CGRectMake(264,20,170,21);
            self.vecreg_ans=[[UILabel alloc]initWithFrame:vecRegansFrame];
            [ self.vecreg_ans setBackgroundColor:[UIColor clearColor]];
            [ self.vecreg_ans setText:@"TN0942358"];
            [ self.vecreg_ans setTextColor:[UIColor blackColor]];
            [ self.vecreg_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect OwnerNameFrame=CGRectMake(91,61,155,21);
            self.ownername=[[UILabel alloc]initWithFrame:OwnerNameFrame];
            [ self.ownername setBackgroundColor:[UIColor clearColor]];
            [ self.ownername setText:@"Driver Name:"];
            [ self.ownername setTextColor:[UIColor blackColor]];
            [ self.ownername setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect OwnerNameansFrame=CGRectMake(264,61,170,21);
            self.ownername_ans=[[UILabel alloc]initWithFrame:OwnerNameansFrame];
            [ self.ownername_ans setBackgroundColor:[UIColor clearColor]];
            [ self.ownername_ans setText:@"John"];
            [ self.ownername_ans setTextColor:[UIColor blackColor]];
            [ self.ownername_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect DistanceFrame=CGRectMake(91,103,181,21);
            self.totalDistance=[[UILabel alloc]initWithFrame:DistanceFrame];
            [ self.totalDistance setBackgroundColor:[UIColor clearColor]];
            [ self.totalDistance setText:@"Distance Travelled:"];
            [ self.totalDistance setTextColor:[UIColor blackColor]];
            [ self.totalDistance setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect DistanceansFrame=CGRectMake(264,103,170,21);
            self.totalDistance_ans=[[UILabel alloc]initWithFrame:DistanceansFrame];
            [ self.totalDistance_ans setBackgroundColor:[UIColor clearColor]];
            [ self.totalDistance_ans setText:@"48 kms"];
            [ self.totalDistance_ans setTextColor:[UIColor blackColor]];
            [ self.totalDistance_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            
            v2  = [[UIView alloc] initWithFrame:CGRectMake(10,202,519,197)];
            [v2 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
            
            CGRect indiimage=CGRectMake(0,0,519,44);
            self.indi_bg=[[UIImageView alloc]initWithFrame:indiimage];
            [ self.indi_bg setImage:[UIImage imageNamed:@"Navbarbg.jpg"]];
            
            CGRect InsFrame=CGRectMake(178,14,163,21);
            self.instruction=[[UILabel alloc]initWithFrame:InsFrame];
            [ self.instruction setBackgroundColor:[UIColor clearColor]];
            [ self.instruction setText:@"Indicator Details"];
            [ self.instruction setTextColor:[UIColor whiteColor]];
            [ self.instruction setFont:[UIFont fontWithName:@"Bangla Sangam MN Bold" size:20.0]];
            
            
            CGRect redimgFrame=CGRectMake(127,61,35,35);
            self.red=[[UIImageView alloc]initWithFrame:redimgFrame];
            [ self.red setImage:[UIImage imageNamed:@"red_pin.png"]];
            
            CGRect pinkimgFrame=CGRectMake(127,107,35,35);
            self.pink=[[UIImageView alloc]initWithFrame:pinkimgFrame];
            [ self.pink setImage:[UIImage imageNamed:@"pink_pin.png"]];
            
            CGRect greenimgFrame=CGRectMake(127,150,35,35);
            self.green=[[UIImageView alloc]initWithFrame:greenimgFrame];
            [ self.green setImage:[UIImage imageNamed:@"startpoint.png"]];
            
           
            
            
            CGRect redansFrame=CGRectMake(172,68,174,21);
            self.red_lab=[[UILabel alloc]initWithFrame:redansFrame];
            [ self.red_lab setBackgroundColor:[UIColor clearColor]];
            [ self.red_lab setText:@"Last Location"];
            [ self.red_lab setTextColor:[UIColor blackColor]];
            [ self.red_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect pinkansFrame=CGRectMake(172,114,220,21);
            self.pink_lab=[[UILabel alloc]initWithFrame:pinkansFrame];
            [ self.pink_lab setBackgroundColor:[UIColor clearColor]];
            [ self.pink_lab setText:@"Overspeed Location"];
            [ self.pink_lab setTextColor:[UIColor blackColor]];
            [ self.pink_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
            CGRect greenansFrame=CGRectMake(172,157,200,21);
            self.green_lab=[[UILabel alloc]initWithFrame:greenansFrame];
            [ self.green_lab setBackgroundColor:[UIColor clearColor]];
            [ self.green_lab setText:@"Start and End Location"];
            [ self.green_lab setTextColor:[UIColor blackColor]];
            [ self.green_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:19]];
            
           
        }
        else if (SCREEN_40)
        {
            greyView= [[UIView alloc] initWithFrame:CGRectMake(0,0,320,568)];
            [greyView setBackgroundColor:[UIColor clearColor]];
            
            
            popUpView  = [[UIView alloc] initWithFrame:CGRectMake(10,100,300,344)];
            [popUpView setBackgroundColor:[UIColor whiteColor]];
            
            self.close = [[UIButton alloc]initWithFrame:CGRectMake(5,9,70,30)];
            [self.close addTarget:self action:@selector(doneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.close setTitle:@"Done" forState:UIControlStateNormal];
            [self.close setUserInteractionEnabled:YES];
            [self.close setTintColor:[UIColor whiteColor]];
            UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            fixedItem.width = -16;
            
            
            UIBarButtonItem *item11=[[UIBarButtonItem alloc]initWithCustomView:self.close];
            navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
            UINavigationItem *item=[[UINavigationItem alloc]initWithTitle:@"Track Information"];
            navbar.items=[NSArray arrayWithObjects:item,nil];
            navbar.topItem.rightBarButtonItems=@[fixedItem,item11,fixedItem,fixedItem];
            // [navbar addSubview:v3];
            
         
            
            
           v1  = [[UIView alloc] initWithFrame:CGRectMake(13,55,274,98)];
            v1.clipsToBounds=YES;
            v1.layer.cornerRadius=10;
            [v1 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
            CGRect vecRegFrame=CGRectMake(7,14,130,21);
            self.vecreg=[[UILabel alloc]initWithFrame:vecRegFrame];
            [ self.vecreg setBackgroundColor:[UIColor clearColor]];
            [ self.vecreg setText:@"Vehicle Reg.No:"];
            [ self.vecreg setTextColor:[UIColor blackColor]];
            [ self.vecreg setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect vecRegansFrame=CGRectMake(151,14,144,21);
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
            
            CGRect OwnerNameansFrame=CGRectMake(151,45,194,21);
            self.ownername_ans=[[UILabel alloc]initWithFrame:OwnerNameansFrame];
            [ self.ownername_ans setBackgroundColor:[UIColor clearColor]];
            [ self.ownername_ans setText:@"John"];
            [ self.ownername_ans setTextColor:[UIColor blackColor]];
            [ self.ownername_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect DistanceFrame=CGRectMake(7,73,160,21);
            self.totalDistance=[[UILabel alloc]initWithFrame:DistanceFrame];
            [ self.totalDistance setBackgroundColor:[UIColor clearColor]];
            [ self.totalDistance setText:@"Distance Travelled:"];
            [ self.totalDistance setTextColor:[UIColor blackColor]];
            [ self.totalDistance setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect DistanceansFrame=CGRectMake(151,73,194,21);
            self.totalDistance_ans=[[UILabel alloc]initWithFrame:DistanceansFrame];
            [ self.totalDistance_ans setBackgroundColor:[UIColor clearColor]];
            [ self.totalDistance_ans setText:@"48 kms"];
            [ self.totalDistance_ans setTextColor:[UIColor blackColor]];
            [ self.totalDistance_ans setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            v2  = [[UIView alloc] initWithFrame:CGRectMake(13,161,274,167)];
            [v2 setBackgroundColor:[UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
            
            CGRect indiimage=CGRectMake(0,0,274,41);
            self.indi_bg=[[UIImageView alloc]initWithFrame:indiimage];
            [ self.indi_bg setImage:[UIImage imageNamed:@"Navbarbg.jpg"]];
            
            CGRect InsFrame=CGRectMake(69,12,145,21);
            self.instruction=[[UILabel alloc]initWithFrame:InsFrame];
            [ self.instruction setBackgroundColor:[UIColor clearColor]];
            [ self.instruction setText:@"Indicator Details"];
            [ self.instruction setTextColor:[UIColor whiteColor]];
            [ self.instruction setFont:[UIFont fontWithName:@"Bangla Sangam MN Bold" size:17.0]];
            
            
            CGRect redimgFrame=CGRectMake(35,57,25,25);
            self.red=[[UIImageView alloc]initWithFrame:redimgFrame];
            [ self.red setImage:[UIImage imageNamed:@"red_pin.png"]];
            
          
            
            CGRect pinkimgFrame=CGRectMake(35,94,25,25);
            self.pink=[[UIImageView alloc]initWithFrame:pinkimgFrame];
            [ self.pink setImage:[UIImage imageNamed:@"pink_pin.png"]];
            
            CGRect greenimgFrame=CGRectMake(35,129,25,25);
            self.green=[[UIImageView alloc]initWithFrame:greenimgFrame];
            [ self.green setImage:[UIImage imageNamed:@"startpoint.png"]];
            
            CGRect redansFrame=CGRectMake(64,59,163,21);
            self.red_lab=[[UILabel alloc]initWithFrame:redansFrame];
            [ self.red_lab setBackgroundColor:[UIColor clearColor]];
            [ self.red_lab setText:@"Last Location"];
            [ self.red_lab setTextColor:[UIColor blackColor]];
            [ self.red_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect pinkansFrame=CGRectMake(64,96,163,21);
            self.pink_lab=[[UILabel alloc]initWithFrame:pinkansFrame];
            [ self.pink_lab setBackgroundColor:[UIColor clearColor]];
            [ self.pink_lab setText:@"Overspeed Location"];
            [ self.pink_lab setTextColor:[UIColor blackColor]];
            [ self.pink_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
            CGRect greenansFrame=CGRectMake(64,133,190,21);
            self.green_lab=[[UILabel alloc]initWithFrame:greenansFrame];
            [ self.green_lab setBackgroundColor:[UIColor clearColor]];
            [ self.green_lab setText:@"Start and End Location"];
            [ self.green_lab setTextColor:[UIColor blackColor]];
            [ self.green_lab setFont:[UIFont fontWithName:@"Bangla Sangam MN" size:15]];
            
           
        }
       
        
        
        self.vecreg_ans.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"vehicleregno"];
        self.ownername_ans.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"driver_name"];
        self.totalDistance_ans.text=@"";
        [v1 addSubview:self.vecreg];
        [v1 addSubview:self.vecreg_ans];
        [v1 addSubview:self.ownername];
        [v1 addSubview:self.ownername_ans];
        [v1 addSubview:self.totalDistance];
        [v1 addSubview:self.totalDistance_ans];
        [v2 addSubview:self.indi_bg];
        [v2 addSubview:self.instruction];
        [v2 addSubview:self.red];
        [v2 addSubview:self.red_lab];
        [v2 addSubview:self.green];
        [v2 addSubview:self.green_lab];
        [v2 addSubview:self.pink];
        [v2 addSubview:self.pink_lab];
        [popUpView addSubview:navbar];
        
        
        
       
    
        
        
        
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
   
}



-(void)answerDoubleTapped:(UIGestureRecognizer*)sender
{
    [greyView removeFromSuperview];
}



- (IBAction)doneButtonSelected:(id)sender
{
 
    [self removeFromSuperview];
   
}






- (void)dealloc {
 
    [super dealloc];
}
@end


