//
//  AboutPageViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 26/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "AboutPageViewController.h"

@interface AboutPageViewController ()
{
    NSArray *contentForTable;
}
@end

@implementation AboutPageViewController

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
    self.navigationController.topViewController.title=@"About";
   
    contentForTable=[[NSArray alloc]initWithObjects:@"Appname : DeemsysGPS",@"Version : 1.0.1",@"Privacy Policy",@"Website URL",@"Marketing URL",nil];
     self.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
         [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];
            UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
            [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
            
            rightBtn.frame = CGRectMake(0, 0, 70, 40 );
            
            self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        }

    UIImage *temp = [UIImage imageNamed:@"back_Icon.png"];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:temp style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
    self.navigationController.navigationItem.leftBarButtonItem=barButtonItem;
}
-(void)action
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) doneButtonSelected{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [contentForTable count];
    
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentIdentifier"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:@"ContentIdentifier"] autorelease];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ((indexPath.row==0)||(indexPath.row==1) ) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if (IS_IPAD) {
          [ cell.textLabel setFont:[UIFont fontWithName:@"Bangla Sangam MN Bold" size:17]];
    }
    else
    {
          [ cell.textLabel setFont:[UIFont fontWithName:@"Bangla Sangam MN Bold" size:17]];
    }
  
    cell.textLabel.text= [contentForTable objectAtIndex:indexPath.row];
   
   
    
    return cell;
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"historydetail"]) {
        NSIndexPath *index=[self.contentTableView indexPathForSelectedRow];
       
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row1=indexPath.row;
    if (row1==2) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            UIViewController *intitalVC= [self.storyboard instantiateViewControllerWithIdentifier:@"Privacy"];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:intitalVC];
             [navController.navigationBar setBarTintColor:[UIColor whiteColor]];
            self.navigationController.navigationBar.backItem.title=@"";
            navController.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            navController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self presentViewController:navController animated:YES completion:nil];
        }
        else
        {
            
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self performSegueWithIdentifier:@"PrivacyPolicy" sender:self];
        }
       
    }
   else if (row1==3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deemgps.com"]];
    }
   else if (row1==4) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.deemgpstracker.com"]];
    }
    
   
    
}


- (void)dealloc {
    [_contentTableView release];
    [super dealloc];
}
@end
