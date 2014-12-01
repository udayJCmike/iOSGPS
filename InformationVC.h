//
//  InformationVC.h
//  DeemGPS
//
//  Created by DeemsysInc on 27/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularTimer.h"

@interface InformationVC : UIView<UIGestureRecognizerDelegate>
{
    UIView *greyView;
      UIView *popUpView;
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
@property (retain, nonatomic) IBOutlet UIButton *close;
@property (retain, nonatomic) IBOutlet UILabel *countDown;
@property (retain, nonatomic) IBOutlet UILabel *vecreg;
@property (retain, nonatomic) IBOutlet UILabel *vecreg_ans;
@property (retain, nonatomic) IBOutlet UILabel *ownername;
@property (retain, nonatomic) IBOutlet UILabel *ownername_ans;
@property (retain, nonatomic) IBOutlet UILabel *instruction;
@property (retain, nonatomic) IBOutlet UILabel *red_lab;
@property (retain, nonatomic) IBOutlet UILabel *green_lab;
@property (retain, nonatomic) IBOutlet UILabel *pink_lab;
@property (retain, nonatomic) IBOutlet UILabel *org_lab;
@property (retain, nonatomic) IBOutlet UILabel *start_end_lab;
@property (retain, nonatomic) IBOutlet UIImageView *red;
@property (retain, nonatomic) IBOutlet UIImageView *green;
@property (retain, nonatomic) IBOutlet UIImageView *pink;
@property (retain, nonatomic) IBOutlet UIImageView *orange;
@property (retain, nonatomic) IBOutlet UIImageView *start_end;
@property (retain, nonatomic) IBOutlet UIImageView *indi_bg;
@property (retain, nonatomic) CircularTimer *circularTimer;
@property (assign) float xOffset;

@property (assign) float yOffset;

@end
