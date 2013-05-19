//
//  RDStationDetailsViewController.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import "RDStationDetailsViewController.h"
#import "RDStation.h"
#import "RDStationMovementCell.h"
#import "RDAppDelegate.h"
#import "RDAppController.h"
#import "RDNetworkOperationManager.h"

@implementation RDStationDetailsViewController

#pragma mark Internal interface
-(void)sortData
{
    self.stationUsage = [self.stationUsage sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSDictionary* movementFirst = obj1;
        NSDictionary* movementSecond = obj2;
        
        NSTimeInterval dueFirst = [[movementFirst objectForKey:@"Duein"]doubleValue];
        NSTimeInterval dueSecond = [[movementSecond objectForKey:@"Duein"]doubleValue];
        
        if(dueFirst < dueSecond)
        {
            return  NSOrderedAscending;
        }
        else if(dueFirst > dueSecond)
        {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
        
    }];
}

-(void)refreshStationUsage
{
    self.informationTextLabel.text = @"Downloading Trains Information ...";
    
    __weak RDStationDetailsViewController* selfWeak = self;
    
    [[[(RDAppDelegate*)[[UIApplication sharedApplication]delegate]appController]networkManager]downloadStationUsageForStation:self.station.stationDesc withCompletionBlock:^(NSArray *stationUsageDescriptions, BOOL completed) {
        
        if(!selfWeak)
        {
            //self was deallocated, do nothing
            return;
        }
        
        if(completed)
        {
            self.stationUsage = stationUsageDescriptions;
            [self sortData];
            [self.tableView reloadData];
            
            if([self.stationUsage count])
            {
                self.informationTextLabel.text = @"Trains Information";
            }
            else
            {
                self.informationTextLabel.text = @"No Trains in next 90 min";
            }
        }
        else
        {
            self.informationTextLabel.text = @"Error Updaing Station";
        }
    }];
    
    double delayInSeconds = 60.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(!selfWeak)
        {
            //self was deallocated, do nothing
            return;
        }
        
        [selfWeak refreshStationUsage];
    });
}

#pragma mark Allocation and Deallocation
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = self.station.stationDesc;
    
    [self refreshStationUsage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

#pragma mark UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* descriptionForStationMovement = [self.stationUsage objectAtIndex:indexPath.row];
    
    RDStationMovementCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"StationMovement"];
    
    [cell setDescriptionAndRefresh:descriptionForStationMovement];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stationUsage count];
}
#pragma mark Public interface

@end
