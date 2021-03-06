//
//  RDStationCell.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <UIKit/UIKit.h>

@class RDStation;

@interface RDStationCell : UITableViewCell

@property(strong)RDStation * station;

- (void)setStationObjectAndRefresh:(RDStation *)station;

@end
