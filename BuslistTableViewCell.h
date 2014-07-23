//
//  BuslistTableViewCell.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuslistTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *driver_name;
@property (strong, nonatomic) IBOutlet UILabel *vehicle_reg_no;
@property (strong, nonatomic) IBOutlet UIImageView *device_status;
//@property(nonatomic,retain)IBOutlet UILabel *vehicle_reg_no;
//@property(nonatomic,retain)IBOutlet UILabel *device_imei_number;
//@property(nonatomic,retain)IBOutlet UILabel *driver_name;
//@property(nonatomic,retain)IBOutlet UILabel *driver_licence_number;
//@property(nonatomic,retain)IBOutlet UILabel *driver_licence_exp_date;
//@property(nonatomic,retain)IBOutlet UILabel *route_no;
//@property(nonatomic,retain)IBOutlet UILabel *device_status;
@end
