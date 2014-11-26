//
//  ProfileContentTableViewCell.m
//  DeemGPS
//
//  Created by DeemsysInc on 26/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import "ProfileContentTableViewCell.h"

@implementation ProfileContentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_Type release];
    [super dealloc];
}
@end
