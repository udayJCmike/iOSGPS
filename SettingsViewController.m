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
}
    - (void) doneButtonSelected{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
