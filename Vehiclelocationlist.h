//
//  Locationlist.h
//  GPSMobileTracking
//
//  Created by DeemsysInc on 15/07/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehiclelocationlist : NSObject
@property(nonatomic,retain)NSString *latitude;
@property(nonatomic,retain)NSString *longitude;
@property(nonatomic,retain)NSString *speed;
@property(nonatomic,retain)NSString *exceed_speed_limit;
@property(nonatomic,retain)NSString *bus_tracking_timestamp;
@property(nonatomic,retain)NSString *address;
@property(nonatomic,retain)NSString *flag;
@property(nonatomic,retain)NSString *devicestatus;
@property BOOL Latest;
@end
