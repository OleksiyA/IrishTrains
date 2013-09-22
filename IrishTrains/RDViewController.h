//
//  RDViewController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RDViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *myLocationTextLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStations;

@property (strong, nonatomic) NSArray *stations;
@property (strong, nonatomic) CLLocation *latestLocation;

- (IBAction)onRefreshTouched:(id)sender;

@end
