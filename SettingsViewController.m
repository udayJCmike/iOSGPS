//
//  SettingsViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 25/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)saveTone:(id)sender {
    [self StopaudioSound];
        
//        NSLog(@"selected tone %@",self.selectedtone.titleLabel.text );
    
        
        [[NSUserDefaults standardUserDefaults]setValue:alarmName  forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
       
        [[NSUserDefaults standardUserDefaults]synchronize];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.topViewController.title=@"Settings";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
        [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        rightBtn.frame = CGRectMake(0, 0, 70, 40 );
        
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
   
    self.savetone.layer.cornerRadius=5;
    self.savetone.clipsToBounds=YES;
    self.selectedtone.layer.cornerRadius=5;
    self.selectedtone.clipsToBounds=YES;
}
- (void) doneButtonSelected{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectClicked:(id)sender
{
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Default",@"Nuclear Alert", @"Car Alert",@"Extreme Alert", @"Handy Alert",nil];
    NSArray * arrImage = [[NSArray alloc] init];
   
    if(dropDown == nil)
    {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
  
}

- (void) niDropDownDelegateMethod: (NSString *) sender
{
//   NSLog(@"selected type %@",sender);
    [self StopaudioSound];
    [self PlaySoundWithName:sender];
  
    [self rel];
}
-(void)StopaudioSound
{
    [_audioPlayer pause];
    [_audioPlayer stop];
    _audioPlayer=nil;
    //  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"StopSound" object:nil];
}
-(void)PlaySoundWithName:(NSString*)alarmName1
{
   
    if (!_audioPlayer)
    {
        if ([alarmName1 isEqualToString:@"Default"]) {
            alarmName=@"Red_Alert";
        }
        else  if ([alarmName1 isEqualToString:@"Nuclear Alert"]) {
            alarmName=@"Nuclear_Alert";
        }
        else  if ([alarmName1 isEqualToString:@"Car Alert"]) {
            alarmName=@"Car_Alert";
        }
        else  if ([alarmName1 isEqualToString:@"Extreme Alert"]) {
            alarmName=@"Extreme_Alert";
        }
        else  if ([alarmName1 isEqualToString:@"Handy Alert"]) {
            alarmName=@"Handy_Alert";
        }
        path   =   [[NSBundle mainBundle] pathForResource:alarmName ofType:@"mp3"];
        soundUrl = [NSURL fileURLWithPath:path];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
        _audioPlayer.numberOfLoops=1;
        
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
-(void)rel{
  
    dropDown = nil;
}
- (void)viewDidUnload {
   
    self.selectedtone = nil;
    
    [super viewDidUnload];
    
}
@end
