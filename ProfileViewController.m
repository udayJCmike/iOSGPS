//
//  ProfileViewController.m
//  DeemGPS
//
//  Created by DeemsysInc on 25/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
   self.navigationController.topViewController.title=@"Profile";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
        [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        rightBtn.frame = CGRectMake(0, 0, 70, 40 );
        
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
    orgname= [[NSUserDefaults standardUserDefaults]valueForKey:@"org_name"];
   number= [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
   address= [[NSUserDefaults standardUserDefaults]valueForKey:@"Org_address"];
  // orgtype= [[NSUserDefaults standardUserDefaults]valueForKey:@"type_of_organization"];
  
    
    profileContent=[[NSArray alloc]initWithObjects:@"Organisation Name ",@"Organization Type ",@"Contact Address ",@"Tel ",nil];
    self.ProfileContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0]} forState:UIControlStateNormal];
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40 )];
        [rightBtn addTarget:self action:@selector(doneButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setTitle:@"Done" forState:UIControlStateNormal];
        
        rightBtn.frame = CGRectMake(0, 0, 70, 40 );
        
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    }
    
    NSString *role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    
    if ([role isEqualToString:@"ROLE_ADMIN"])
    {
        [self.banner setImage:[UIImage imageNamed:@"school_cover.jpg"]];
         orgtype=@"School";
        
    }
    else  if ([role isEqualToString:@"ROLE_PCLIENT"])
    {
           [self.banner setImage:[UIImage imageNamed:@"personal_cover.jpg"]];
         orgtype=@"Personal";
        
    }
    else  if ([role isEqualToString:@"ROLE_FCLIENT"])
    {
           [self.banner setImage:[UIImage imageNamed:@"fleet_cover.jpg"]];
         orgtype=@"Fleet";
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [profileContent count];
    
    // Return the number of rows in the section.
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        return 120;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *iden=@"ContentIdentifier";
    if (indexPath.row ==2) {
      iden=@"AddressIdentifier";
    }
    ProfileContentTableViewCell *cell = (ProfileContentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[ProfileContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault   reuseIdentifier:iden] autorelease];
    }
    if (indexPath.row==0) {
        cell.value.text= orgname;
    }
    else if (indexPath.row==1) {
        cell.value.text= orgtype;
    }
    else if (indexPath.row==2) {
        
        cell.value.text= address;
    }
    else if (indexPath.row==3) {
        cell.value.text= number;
    }
    
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.Type.lineBreakMode = NSLineBreakByWordWrapping;
    cell.Type.numberOfLines = 0;
    cell.Type.text= [profileContent objectAtIndex:indexPath.row];
    
    
    cell.value.lineBreakMode = NSLineBreakByWordWrapping;
    cell.value.numberOfLines = 0;
  
    
    return cell;
    
    
}

- (void)dealloc {
    [_ProfileContent release];
    [super dealloc];
}
@end
