//
//  RDStationDetailsViewController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RDStation;

@interface RDStationDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *informationTextLabel;


@property(strong)RDStation*         station;
@property(strong)NSArray*           stationUsage;

@end
