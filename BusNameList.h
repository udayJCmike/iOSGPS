//
//  BusNameList.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 14/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusNameList : NSObject

@property(nonatomic,retain)NSString *vehicle_reg_no;
@property(nonatomic,retain)NSString *device_imei_number;
@property(nonatomic,retain)NSString *driver_name;
@property(nonatomic,retain)NSString *driver_licence_number;
@property(nonatomic,retain)NSString *driver_licence_exp_date;
@property(nonatomic,retain)NSString *route_no;
@property(nonatomic,retain)NSString *device_status;
@end
