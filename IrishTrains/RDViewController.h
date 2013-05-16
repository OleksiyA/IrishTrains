//
//  RDViewController.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RDViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *myLocationTextLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableViewStations;

@property (strong)NSArray*                  stations;
@property (strong)CLLocation*               latestLocation;

- (IBAction)onRefreshTouched:(id)sender;

@end
