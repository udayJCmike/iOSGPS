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
        
         NSDate *TickTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"];
        NSDate *startTime=[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"];
        interval=[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue];
        NSLog(@"tick date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"ticktime"]);
        NSLog(@"start date in popover %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"StartDate"]);
        NSLog(@"tick count in popover %d",[[[NSUserDefaults standardUserDefaults]valueForKey:@"tickcount"] intValue]);
        NSDate *endTime=[TickTime dateByAddingTimeInterval:interval];
        NSLog(@"End date in popover %@",endTime);
        
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
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//
//  LiveTrackInformationViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//




- (void) doneButtonSelected{
    self.circularTimer = nil;
    [self.circularTimer removeFromSuperview];
    [CountDownTimer invalidate];
    [self removeFromSuperview];
}

    


- (void)viewWillAppear:(BOOL)animated
{
    [self createCircle];
    
    
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
    
    [self addSubview:self.circularTimer];
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


