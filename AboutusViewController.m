//
//  AboutusViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "AboutusViewController.h"
#import "databaseurl.h"
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface AboutusViewController ()
{
    databaseurl * du;
}

@end

@implementation AboutusViewController
@synthesize imageview;
@synthesize scroll_height;
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
    
    NSString *filename = [du imagecheck:@"about.png"];
    NSLog(@"image name %@",filename);
    
    imageview.image = [UIImage imageNamed:filename];
    
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == scrollview && con.firstAttribute == NSLayoutAttributeTop) {
                
                con.constant =160;
                self.scrollview_height.constant=330;
                self.scroll_height.constant = 161;
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



- (void)dealloc {
  
 
    
   
 [super dealloc];
}
@end
