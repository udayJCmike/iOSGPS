//
//  AboutusViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "AboutusViewController.h"
#import "databaseurl.h"

@interface AboutusViewController ()
{
    databaseurl * du;
}

@end

@implementation AboutusViewController
@synthesize imageview;

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
    //    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    //        CGRect screenRect = [[UIScreen mainScreen] bounds];
    //        if (screenRect.size.height == 1024.0f)
    //        {
    //            filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@"~ipad.png"];
    //            // code for 4-inch screen
    //        } else {
    //            filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@"@2x~ipad.png"];
    //            // code for 3.5-inch screen
    //        }
    //
    //    }
    //    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
    //
    //        CGRect screenRect = [[UIScreen mainScreen] bounds];
    //        if (screenRect.size.height == 568.0f)
    //        {
    //            filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@"-568h@2x.png"];
    //            // code for 4-inch screen
    //        } else {
    //            filename = [filename stringByReplacingOccurrencesOfString:@".png" withString:@"@2x.png"];
    //            // code for 3.5-inch screen
    //        }
    //
    //    }
    
    
    imageview.image = [UIImage imageNamed:filename];
   

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
