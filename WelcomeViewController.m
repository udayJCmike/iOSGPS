//
//  WelcomeViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "WelcomeViewController.h"


#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_35 (SCREEN_HEIGHT == 480)
#define SCREEN_40 (SCREEN_HEIGHT == 568)
@interface WelcomeViewController ()
{
    databaseurl *du;
    GPSMobileTrackingAppDelegate *delegate;
    
}

@end

@implementation WelcomeViewController
@synthesize tableView;
@synthesize imageview;
@synthesize welcome;
@synthesize aboutus;
@synthesize contactus;
@synthesize logout;

@synthesize tableheightConstraint;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item

{
    
        if(item.tag == 0)
        {
            [self profile:nil];
            
        }
        if(item.tag == 1)
        {
            [self aboutUS:nil];
            
        }
        if(item.tag == 2)
        {
            [self contactUS:nil];
        }
        if(item.tag == 3)
        {
            [self settings:nil];
        }
        if(item.tag == 4)
        {
            [self logout:nil];
        }
    
}
- (IBAction)settings:(id)sender
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Settings_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initialvc];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
        
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Settings_iPhone" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        
    }
}
- (IBAction)logout:(id)sender {
    
delegate.login_status=@"0";
  if([delegate.Background_Runner isValid])
  {
    [delegate.Background_Runner invalidate];
    
  }
   [[NSNotificationCenter defaultCenter] postNotificationName:@"StopSound" object:self  userInfo:nil];
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if ([delegate.login_session_status isEqualToString:@"1"])
    {
       // NSLog(@"logged out using session");
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            UIViewController *initialvc=[welcome1 instantiateInitialViewController];
            delegate.window.rootViewController =initialvc;
            
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            UIViewController *initialvc=[welcome1 instantiateInitialViewController];
            delegate.window.rootViewController =initialvc;
            
        }
       
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
//    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
//    {
//        self.navigationController.navigationBarHidden=YES;
//        self.navigationItem.hidesBackButton=YES;
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//        
//    }
//    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//        
//        
//        self.navigationController.navigationBarHidden=YES;
//        self.navigationItem.hidesBackButton=YES;
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
   list= delegate.Vehicle_List;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIButton* back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    UIBarButtonItem *button11 = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = button11;
    if(SCREEN_35)
    {
        
        for (NSLayoutConstraint *con in self.view.constraints)
        {
            if (con.firstItem == welcome && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 100;
            }
            if (con.firstItem == logout && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 104;
            }
            if (con.firstItem == aboutus && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 440;
            }
            if (con.firstItem == contactus && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant =440;
            }
            if (con.firstItem == tableView && con.firstAttribute == NSLayoutAttributeTop) {
                con.constant = 130;
                self.tableheightConstraint.constant = 300;
                    [self.tableView needsUpdateConstraints];
                    
               
                
            }
        }
    }
    
 self.navigationController.topViewController.title=@"Dashboard";

    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
   
    delegate=AppDelegate;
    du=[[databaseurl alloc]init];
//    NSString *filename = [du imagecheck:@"dashboard.jpg"];
//    imageview.image = [UIImage imageNamed:filename];
     list= delegate.Vehicle_List;
    UIImage *image = [UIImage imageNamed:@"Menu_Icon.png"];
    UIButton* requestButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 35)];
    [requestButton setImage:image forState:UIControlStateNormal];
    [requestButton addTarget:self action:@selector(MenuButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithCustomView:requestButton];
    self.navigationItem.rightBarButtonItem = button1;
    
    if ([delegate.login_session_status isEqualToString:@"1"])
    {
        HUD = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        HUD.mode=MBProgressHUDModeIndeterminate;
        HUD.delegate = self;
        HUD.labelText = @"Please wait";
        [HUD show:YES];
        [HUD hide:YES afterDelay:0.5f];
      // NSLog(@"observer added");
        
    }
    // Do any additional setup after loading the view.
}
-(void)MenuButton
{
    
}
-(void)ReloadTable_Method
{
    //  NSLog(@"observer called");
    if ([delegate.login_status isEqualToString:@"1"])
    {
        //  NSLog(@"observer called");
     list= delegate.Vehicle_List;
    [self.tableView reloadData];
    [HUD hide:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadTable" object:nil];
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
            UIViewController *initialvc=[welcome1 instantiateInitialViewController];
            delegate.window.rootViewController =initialvc;
            
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            
            UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            UIViewController *initialvc=[welcome1 instantiateInitialViewController];
            delegate.window.rootViewController =initialvc;
            
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Bus List";
    BuslistTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell==nil) {
        cell=[[BuslistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    BusNameList *list1=[list objectAtIndex:indexPath.row];
   
    cell.vehicle_reg_no.text=list1.vehicle_reg_no;
    cell.current_speed.text=list1.speed;
    cell.current_location.text=list1.address;
    cell.last_update.text=list1.bus_tracking_timestamp;
    if (([list1.alarm_status isEqualToString:@"0"])||([list1.alarm_status isEqualToString:@"1"]) ) {
       cell. alert_label_red.hidden=YES;
    }
    else if ([list1.alarm_status isEqualToString:@"2"]) {
       cell.  alert_label_red.hidden=NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlaySound"
                                                                object:self
                                                              userInfo:nil];
        
    }
    
        if ([list1.device_status isEqualToString:@"0"]) {
            cell.device_status.image=[UIImage imageNamed:@"Circle_Red.png"];
        }
        else if ([list1.device_status isEqualToString:@"1"]) {
            cell.device_status.image=[UIImage imageNamed:@"Circle_Green.png"];
        }
        else if ([list1.device_status isEqualToString:@"2"])
        {
            cell.device_status.image=[UIImage imageNamed:@"Circle_Yellow.png"];
        }
        else if ([list1.device_status isEqualToString:@"3"])
        {
            cell.device_status.image=[UIImage imageNamed:@"Circle_Orange.png"];
            
        }
        else
            cell.device_status.image=[UIImage imageNamed:@"Circle_Red.png"];

    

   
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BusNameList *list1=[list objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setValue:list1.vehicle_reg_no forKey:@"vehicleregno"];
     [[NSUserDefaults standardUserDefaults]setValue:list1.driver_name forKey:@"driver_name"];
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"selected_row"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Vehicletrack_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Vehicletrack_iPhone" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    
  
    [super dealloc];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadTable" object:nil];
}
- (IBAction)aboutUS:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Aboutus_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initialvc];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Aboutus_iPhone" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
    }

}

- (IBAction)contactUS:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Contactus_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initialvc];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];

     
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Contactus_iPhone" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
    }

}
- (IBAction)profile:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Profile_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:initialvc];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:navController animated:YES completion:nil];
       
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Profile_iPhone" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
       
    }
    
}


@end

