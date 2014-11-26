//
//  GPSMobileTrackingAppDelegate.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "GPSMobileTrackingAppDelegate.h"
#define interval 120
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/25
@implementation GPSMobileTrackingAppDelegate
@synthesize login_status;
@synthesize Vehicle_List;
@synthesize Background_Runner;
@synthesize GPSViewController;
@synthesize login_session_status;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    //Navigation bar color
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Navbarbg.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    // Override point for customization after application launch.
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
    
    

  [UINavigationBar appearance].barTintColor   = [UIColor whiteColor];
    GPSViewController=[[GPSMobileTrackingViewController alloc]init];
    login_status =@"0";
    Vehicle_List=[[NSMutableArray alloc]init];
     [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(PlaySound) name:@"PlaySound"object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(StopSound) name:@"StopSound"object:nil];
    if (([[[NSUserDefaults standardUserDefaults]valueForKey:@"username"] length]>0)&&([[[NSUserDefaults standardUserDefaults]valueForKey:@"password"] length]>0))
    {
        login_session_status=@"1";
        [GPSViewController LoginWithSession];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPad" bundle:nil];
            UIViewController *initialvc=[welcome instantiateInitialViewController];
           
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            [navigationController pushViewController:initialvc animated:YES];
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            UIStoryboard *welcome=[UIStoryboard storyboardWithName:@"Welcome_iPhone" bundle:nil];
            UIViewController *initialvc=[welcome instantiateInitialViewController];
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            [navigationController pushViewController:initialvc animated:YES];
           
        }
    }
    else
    {
        login_session_status=@"0";
    }
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
     if ([login_status isEqualToString:@"1"]) {
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        __block UIBackgroundTaskIdentifier bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            [Background_Runner invalidate];
            Background_Runner = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(getVehiceList1) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:Background_Runner forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
    
     }


}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StopSound" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PlaySound" object:nil];
}
-(void)DownloadVehicleListInBackend
{
  //  NSLog(@"perform trigger action");
   dispatch_async(dispatch_get_main_queue(), ^{
                            
//                             if (![Background_Runner isValid]) {
                               //  NSLog(@"timer start");
                                 Background_Runner = [NSTimer scheduledTimerWithTimeInterval:interval
                                                                          target:self
                                                                        selector:@selector(getVehiceList1)
                                                                        userInfo:nil
                                                                         repeats:YES];
                             //}
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 
                             });
                             
                             
                         });
}
-(void)getVehiceList1
{
   //NSLog(@"perform trigger action1");
    
    [GPSViewController getVehicleList];
   [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(PlaySound) name:@"PlaySound"object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(StopSound) name:@"StopSound"object:nil];
    
}
-(void)StopSound
{
    [_audioPlayer pause];
    [_audioPlayer stop];
    _audioPlayer=nil;
  //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StopSound" object:nil];
}
-(void)PlaySound
{
     if (!_audioPlayer)
    {
        path   =   [[NSBundle mainBundle] pathForResource:@"beep1" ofType:@"caf"];
        soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
        _audioPlayer.numberOfLoops=-1;
        
        if (error)
        {
            NSLog(@"Error in audioPlayer: %@",
                  [error localizedDescription]);
        }
        else
        {
            _audioPlayer.delegate = self;
            // [_audioPlayer setNumberOfLoops:3];
        }
        
    }
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    
   // [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PlaySound" object:nil];
}
@end
