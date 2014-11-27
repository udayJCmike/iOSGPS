//
//  InformationVC.h
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularTimer.h"

@interface InformationVC : UIView
{
    int interval;
    NSTimer *CountDownTimer;
    int TotalSec;
}
@property float radius;
@property float internalRadius;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *activeCircleStrokeColor;
@property (nonatomic, strong) NSDate *initialDate;
@property (nonatomic, strong) NSDate *finalDate;
@property (retain, nonatomic) IBOutlet UILabel *countDown;


@property (retain, nonatomic) CircularTimer *circularTimer;
@end
