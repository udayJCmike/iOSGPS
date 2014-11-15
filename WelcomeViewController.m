//
//  WelcomeViewController.m
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "WelcomeViewController.h"
#import "BusNameList.h"
#import "BuslistTableViewCell.h"
#import "databaseurl.h"
#import "SBJSON.h"
#import "GPSMobileTrackingAppDelegate.h"
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
   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        self.navigationController.navigationBarHidden=YES;
        self.navigationItem.hidesBackButton=YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        
        self.navigationController.navigationBarHidden=YES;
        self.navigationItem.hidesBackButton=YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
   list= delegate.Vehicle_List;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        self.navigationController.navigationBarHidden=YES;
        self.navigationItem.hidesBackButton=YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
    }
    else if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        
        
        self.navigationController.navigationBarHidden=YES;
        self.navigationItem.hidesBackButton=YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }

    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults]objectForKey:@"username"]];
   
    delegate=AppDelegate;
    du=[[databaseurl alloc]init];
    NSString *filename = [du imagecheck:@"dashboard.jpg"];
    imageview.image = [UIImage imageNamed:filename];
   // NSLog(@"%@ vehicle list",delegate.Vehicle_List);
  list= delegate.Vehicle_List;
   // [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(ReloadTable_Method) name:@"ReloadTable"object:nil];
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
//-(void)getData
//{
//    
//    if ([[du submitvalues]isEqualToString:@"Success"])
//    {
//       
//        NSString *orgid=[[NSUserDefaults standardUserDefaults]objectForKey:@"orgid"];
//  
//        NSString *response=[self HttpPostEntityFirst1:@"orgid" ForValue1:orgid  EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
//      
//        NSError *error;
//        SBJSON *json = [[SBJSON new] autorelease];
//       
//        NSDictionary *parsedvalue = [json objectWithString:response error:&error];
//        list=[[NSMutableArray alloc]init];
//      
//        if (parsedvalue == nil)
//        {
//            
//            //NSLog(@"parsedvalue == nil");
//            
//        }
//        else
//        {
//            
//            NSDictionary* menu = [parsedvalue objectForKey:@"serviceresponse"];
//            NSArray *datas=[menu objectForKey:@"vehicle List"];
//            
//          
//            //     To check whether its having data or not
////              NSLog(@"datas %lu",(unsigned long)[datas count]);
//            
//            if ([datas count]>0)
//            {
//                
//                for (id anUpdate1 in datas)
//                {
//                    NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
//                    
//                    BusNameList *list1=[[BusNameList alloc]init];
//                   list1.vehicle_reg_no=[arrayList1 objectForKey:@"vehicle_reg_no"];
//                    list1.speed =[arrayList1 objectForKey:@"speed"];
//                    list1.device_status =[arrayList1 objectForKey:@"device_status"];
//                    list1.bus_tracking_timestamp =[arrayList1 objectForKey:@"bus_tracking_timestamp"];
//                    list1.address =[arrayList1 objectForKey:@"address"];
//                     list1.driver_name =[arrayList1 objectForKey:@"driver_name"];
//                    [list addObject:list1];
//                }
//               
//            }
//            else
//            {
//                
//            }
//        }
//        
//    }
//    else
//    {
//     NSLog(@"failure");
//    }
//
//}
//-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
//{
//    
//    
//    NSString *urltemp=[[databaseurl sharedInstance]DBurl];
//    NSString *url1=@"Vehicledetails.php?service=vehiclelist";
//    NSString *url2=[NSString stringWithFormat:@"%@%@",urltemp,url1];
//    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,secondEntity,value2];
//    NSURL *url = [NSURL URLWithString:url2];
////    NSLog(@"post %@",post);
//    NSString *data=[du returndbresult:post URL:url];
////    NSLog(@"datas in wel %@",data);
//    return data;
//}
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
       if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if ([list1.device_status isEqualToString:@"0"]) {
            cell.device_status.image=[UIImage imageNamed:@"indicator_red.png"];
        }
        else if ([list1.device_status isEqualToString:@"1"]) {
            cell.device_status.image=[UIImage imageNamed:@"indicator_green.png"];
        }
        else if (([list1.device_status isEqualToString:@"2"])|| ([list1.device_status isEqualToString:@"3"]))
        {
            cell.device_status.image=[UIImage imageNamed:@"indicator_yellow.png"];
        }
        else
        {
            cell.device_status.image=[UIImage imageNamed:@"indicator_red.png"];
            
        }

    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        if ([list1.device_status isEqualToString:@"0"]) {
            cell.device_status.image=[UIImage imageNamed:@"red_light.png"];
        }
        else if ([list1.device_status isEqualToString:@"1"]) {
            cell.device_status.image=[UIImage imageNamed:@"green_light.png"];
        }
        else if (([list1.device_status isEqualToString:@"2"])|| ([list1.device_status isEqualToString:@"3"]))
        {
            cell.device_status.image=[UIImage imageNamed:@"yellow_light.png"];
        }
        else
        {
            cell.device_status.image=[UIImage imageNamed:@"red_light.png"];
            
        }

    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSLog(@"did select called");
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
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReloadTable" object:nil];
}
- (IBAction)about:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Aboutus_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
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

- (IBAction)contact:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        UIStoryboard *welcome1=[UIStoryboard storyboardWithName:@"Contactus_iPad" bundle:nil];
        UIViewController *initialvc=[welcome1 instantiateInitialViewController];
        [self.navigationController pushViewController:initialvc animated:YES];
        //    initialvc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        //    [self presentModalViewController:initialvc animated:YES];
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
@end
