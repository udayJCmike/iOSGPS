//
//  TermsViewController.h
//  GPSMobileTracking
//
//  Created by Deemsys on 15/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageview;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *scroll_height;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *scroll_bottom;
@end
