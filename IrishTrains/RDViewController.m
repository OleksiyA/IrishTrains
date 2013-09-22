//
//  RDViewController.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import "RDViewController.h"
#import "RDStation.h"
#import "RDStationCell.h"
#import "RDAppDelegate.h"
#import "RDAppController.h"
#import "RDStationDetailsViewController.h"

@implementation RDViewController

#pragma mark Internal interface
- (void)fetchStationsList
{
    self.stations = [[(RDAppDelegate *)[[UIApplication sharedApplication]delegate]appController]listOfStations];
}

- (void)sortData
{
    self.stations = [self.stations sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        RDStation *stationFirst = (RDStation *)obj1;
        RDStation *stationSecond = (RDStation *)obj2;
        
        CLLocationDistance distanceFirst = [self.latestLocation distanceFromLocation:[[CLLocation alloc]initWithLatitude:stationFirst.latitude.doubleValue longitude:stationFirst.longitude.doubleValue]];
        CLLocationDistance distanceSecond = [self.latestLocation distanceFromLocation:[[CLLocation alloc]initWithLatitude:stationSecond.latitude.doubleValue longitude:stationSecond.longitude.doubleValue]];
        
        if (distanceFirst < distanceSecond) {
            return  NSOrderedAscending;
        } else if (distanceFirst > distanceSecond) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
        
    }];
}

- (void)setMyLocationTextLabelTextWithLocation:(CLLocation *)location
{
    self.myLocationTextLabel.text = [NSString stringWithFormat:@"My Location: %.4f Lat; %.4f Lon", location.coordinate.latitude, location.coordinate.longitude];
}

- (void)onLocationUpdated:(NSNotification *)notification
{
    CLLocation *location = notification.object;
    
    self.latestLocation = location;
    
    [self setMyLocationTextLabelTextWithLocation:self.latestLocation];
    
    [self sortData];
    
    [self.tableViewStations reloadData];
}

- (void)onStationsUpdated:(NSNotification *)notification
{
    [self fetchStationsList];
    
    [self sortData];
    
    [self.tableViewStations reloadData];
}

- (void)unsubscribeFromNotifications
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)subscribeToNotifications
{
    [self unsubscribeFromNotifications];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onLocationUpdated:) name:@"LocationUpdated" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onStationsUpdated:) name:@"StationsUpdated" object:nil];
}

#pragma mark Allocation and Deallocation
- (void)dealloc
{
    [self unsubscribeFromNotifications];
}

#pragma mark UIViewController methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self subscribeToNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self onRefreshTouched:nil];
    [self onStationsUpdated:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showStationDetails"]) {
        RDStationDetailsViewController *vc = (RDStationDetailsViewController *)segue.destinationViewController;
        RDStationCell *cell = (RDStationCell *)sender;
        vc.station = cell.station;
    }
}

#pragma mark Public interface
- (IBAction)onRefreshTouched:(id)sender
{
    [[(RDAppDelegate *)[[UIApplication sharedApplication]delegate]appController]requestUpdatedUserLocation];
}

#pragma mark UITableViewDelegate methods

#pragma mark UITableViewDataSource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row >= [self.stations count] ) {
        NSLog(@"Index is out of bounds [%@].", indexPath);
        
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tmp"];
    }
    
    RDStation *station = [self.stations objectAtIndex:indexPath.row];
    
    RDStationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stationCell"];
    
    [cell setStationObjectAndRefresh:station];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stations count];
}

@end
