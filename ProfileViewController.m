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
   
    orgname=@"DeemsysGPS";
    orgtype=@"Fleet";
    address=@"8/41,Jakkappan Nagar,1St Cross,Krishnagiri-635001";
    number=@"9940854293";
    
    profileContent=[[NSArray alloc]initWithObjects:@"Organization Name :",@"Organization Type :",@"Contact Address :",@"Tel :",nil];
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
