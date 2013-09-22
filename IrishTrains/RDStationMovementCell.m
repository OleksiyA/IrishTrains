//
//  RDStationMovementCell.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/19/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import "RDStationMovementCell.h"

@implementation RDStationMovementCell

#pragma mark UITableViewCell methods
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Public interface
- (void)setDescriptionAndRefresh:(NSDictionary *)descriptionForStationMovement
{
    self.textLabel.text = [NSString stringWithFormat:@"%@-%@ in %@ min", [descriptionForStationMovement objectForKey:@"Origin"], [descriptionForStationMovement objectForKey:@"Destination"], [descriptionForStationMovement objectForKey:@"Duein"]];
}

@end
