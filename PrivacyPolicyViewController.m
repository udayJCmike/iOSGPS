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

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=NO;
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    du=[[databaseurl alloc]init];
    
    NSString *filename = [du imagecheck:@"privacy.jpg"];
    NSLog(@"image name %@",filename);
    
    imageview.image = [UIImage imageNamed:filename];
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
