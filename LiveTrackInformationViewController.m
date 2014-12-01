//
//  LiveTrackInformationViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "LiveTrackInformationViewController.h"
#import "CircularTimer.h"
@interface LiveTrackInformationViewController ()
@property (nonatomic, strong) CircularTimer *circularTimer;
@end

@implementation LiveTrackInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) doneButtonSelected{
    self.circularTimer = nil;
    [self.circularTimer removeFromSuperview];
    [CountDownTimer invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.v1.clipsToBounds=YES;
    self.v1.layer.cornerRadius=10;
    
    self.navigationController.topViewController.title=@"Live Information";
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
        [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
        rightBtn.frame = CGRectMake(0, 0, 70, 40 );
        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem.width = -16;
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        [self.navigationItem setRightBarButtonItems:@[fixedItem,right,fixedItem]];
    NSDate *TickTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"];
      NSDate *startTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"];
     interval=[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue];
//    NSLog(@"tick date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"]);
//    NSLog(@"start date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"]);
//     NSLog(@"tick count in popover %d",[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue]);
     NSDate *endTime=[TickTime dateByAddingTimeInterval:interval];
//    NSLog(@"End date in popover %@",endTime);

    self.initialDate=startTime;
    self.finalDate=endTime;
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
       self.radius=100;
        self.internalRadius=50;
        self.circleStrokeColor=[UIColor grayColor];
        self.activeCircleStrokeColor=[UIColor colorWithRed:15/255.0 green:164/255.0 blue:225/255.0 alpha:1.0] ;
        
    }
    else
    {
        self.radius=100;
        self.internalRadius=50;
        self.circleStrokeColor=[UIColor grayColor];
        self.activeCircleStrokeColor=[UIColor colorWithRed:15/255.0 green:164/255.0 blue:225/255.0 alpha:1.0] ;
    }
   self.VecRegNo.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"vehicleregno"];
   self.DriverName.text= [[NSUserDefaults standardUserDefaults]valueForKey:@"driver_name"];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [self createCircle];
    

}
-(void)restartCircle
{
//    NSDate *TickTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"];
//    NSDate *startTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"];
//    interval=[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue];
//    NSDate *endTime=[TickTime dateByAddingTimeInterval:interval];
    NSDate *endTime=[[NSDate date] dateByAddingTimeInterval:30];
    self.circularTimer.initialDate=[NSDate date];
    self.circularTimer.finalDate=endTime;
     TotalSec=30;
//    self.initialDate=startTime;
//    self.finalDate=endTime;
//     TotalSec=interval;
//   self.countDown.text=[NSString stringWithFormat:@"%02d",interval];
   
    [self.circularTimer setup];
 

}
- (void)createCircle
{
    self.circularTimer = [[CircularTimer alloc] initWithPosition:CGPointMake(150.0f, 10.0f)
                                                          radius:self.radius
                                                  internalRadius:self.internalRadius
                                               circleStrokeColor:self.circleStrokeColor
                                         activeCircleStrokeColor:self.activeCircleStrokeColor
                                                     initialDate:self.initialDate
                                                       finalDate:self.finalDate
                                                   startCallback:^{
                                                       NSLog(@"Running!");
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
     NSLog(([self.circularTimer willRun]) ? @"Circle will run" : @"Circle won't run");
    
    [self.view addSubview:self.circularTimer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_v2 release];
    [_VecRegNo release];
    [_DriverName release];
    [super dealloc];
}
@end
