//
//  LiveTrackInformationViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveTrackInformationViewController : UIViewController
{
    int interval;
    NSTimer *CountDownTimer;
    int TotalSec;
}
@property (retain, nonatomic) IBOutlet UILabel *VecRegNo;
@property (retain, nonatomic) IBOutlet UILabel *DriverName;
@property float radius;
@property float internalRadius;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;
@property (retain, nonatomic) IBOutlet UILabel *countDown;
@property (retain, nonatomic) IBOutlet UIView *v2;
@property (retain, nonatomic) IBOutlet UIView *v1;
@end
