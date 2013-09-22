//
//  RDStationMovementCell.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/19/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <UIKit/UIKit.h>

@interface RDStationMovementCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *descriptionForStationMovement;

- (void)setDescriptionAndRefresh:(NSDictionary *)descriptionForStationMovement;

@end
