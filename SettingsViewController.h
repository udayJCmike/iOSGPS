//
//  SettingsViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 25/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface SettingsViewController : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
- (IBAction)selectClicked:(id)sender;
-(void)rel;
@property (retain, nonatomic) IBOutlet UIButton *savetone;
@property (retain, nonatomic) IBOutlet UIButton *selectedtone;
@end
