//
//  ProfileViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 25/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileContentTableViewCell.h"
@interface ProfileViewController : UIViewController
{
    NSArray *profileContent;
    NSString *orgname,*orgtype,*address,*number;
    
}
@property (retain, nonatomic) IBOutlet UITableView *ProfileContent;
@property (retain, nonatomic) IBOutlet UIImageView *banner;
@end
