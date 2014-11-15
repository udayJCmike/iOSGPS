//
//  GPSMobileTrackingAppDelegate.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSMobileTrackingViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@class GPSMobileTrackingViewController;
@interface GPSMobileTrackingAppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>
{
    AVAudioPlayer *audioPlayer;
    NSString *path;
    NSURL *soundUrl;
    NSError *error;
    
}
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString * login_status; //Flag to check whether user loggedin or not
@property(nonatomic,strong)NSMutableArray * Vehicle_List;
@property(nonatomic,strong) NSTimer *Background_Runner;
@property(nonatomic,strong)GPSMobileTrackingViewController *GPSViewController;
@property(nonatomic,strong)NSString * login_session_status;  //Flag to check whether its a session login or user login
-(void)DownloadVehicleListInBackend;
-(void)getVehiceList1;
@end
