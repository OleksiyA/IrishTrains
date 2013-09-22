//
//  RDStationCell.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import "RDStationCell.h"
#import "RDStation.h"

@implementation RDStationCell

#pragma mark Internal interface
- (void)refreshUI
{
    self.textLabel.text = self.station.stationDesc;
}

#pragma mark Public Interface
- (void)setStationObjectAndRefresh:(RDStation *)station
{
    self.station = station;
    
    [self refreshUI];
}

@end
