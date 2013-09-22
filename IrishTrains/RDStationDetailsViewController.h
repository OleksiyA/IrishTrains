//
//  RDStationDetailsViewController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <UIKit/UIKit.h>

@class RDStation;

@interface RDStationDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *informationTextLabel;


@property (strong, nonatomic) RDStation *station;
@property (strong, nonatomic) NSArray *stationUsage;

@end
