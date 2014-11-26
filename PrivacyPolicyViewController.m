//
//  PrivacyPolicyViewController.m
//  GPSMobileTracking
//
//  Created by Deemsys on 15/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "PrivacyPolicyViewController.h"
#import "databaseurl.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface PrivacyPolicyViewController ()
{
    databaseurl * du;
}

@end

@implementation PrivacyPolicyViewController
@synthesize imageview;
@synthesize scrollview;
@synthesize scrollview_height;
@synthesize scroll_bottom;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) doneButtonSelected{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    [self.navigationController.navigationBar setTranslucent:NO];
    [super viewDidLoad];
    
  // [self.navigationController setNavigationBarHidden:NO animated:YES];
    du=[[databaseurl alloc]init];
     self.navigationController.topViewController.title=@"Privacy Policy";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
        [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        rightBtn.frame = CGRectMake(0, 0, 70, 40 );
        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedItem.width = -16;
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
         [self.navigationItem setRightBarButtonItems:@[fixedItem,right,fixedItem]];
    }

    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == scrollview && con.firstAttribute == NSLayoutAttributeTop) {
                
                con.constant =160;
                self.scrollview_height.constant=140;
                
                
                scroll_bottom.constant=60;
                [self.scrollview needsUpdateConstraints];
                
            }
            
            
            
            
        }
    }
    
    
 
    
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

- (void)dealloc {
    
    [super dealloc];
}
@end
