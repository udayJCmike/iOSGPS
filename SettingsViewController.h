//
//  SettingsViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 25/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface SettingsViewController : UIViewController<NIDropDownDelegate,AVAudioPlayerDelegate>
{
    NIDropDown *dropDown;
     AVAudioPlayer *audioPlayer;
    NSString *path;
    NSURL *soundUrl;
    NSError *error;
  NSString *alarmName;
}
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)selectClicked:(id)sender;
-(void)rel;
@property (retain, nonatomic) IBOutlet UIButton *savetone;
@property (retain, nonatomic) IBOutlet UIButton *selectedtone;
@end
