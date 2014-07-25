//
//  Pin.m
//  Locations
//
//  Created by Jay Versluis on 20/03/2014.
//  Copyright (c) 2014 Pinkstone Pictures LLC. All rights reserved.
//

#import "Pin.h"

@implementation Pin

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate {
    
    self = [super init];
    if (self) {
        _coordinate = newCoordinate;
        _title = @"";
        _subtitle = @"";
    }
    return self;
}

@end
