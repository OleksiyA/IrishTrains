//
//  RDNetworkOperationManager.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/15/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import "RDNetworkOperationManager.h"
#import "GTMHTTPFetcher.h"
#import "RDXmlParserHelper.h"

@implementation RDNetworkOperationManager

#pragma mark Internal interface
-(void)stationsDescriptionsFromXML:(NSData*)retrievedData withStationDownloadedBlock:(void(^)(NSDictionary* stationDescription))blockStationReady
{
    if(![retrievedData length])
    {
        return;
    }
    
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:retrievedData];
    
    RDXmlParserHelper* parserHelper = [[RDXmlParserHelper alloc]init];
    parserHelper.blockElementStarted = ^(NSString* elementName)
    {
        if([elementName isEqualToString:@"objStation"])
        {
            return YES;
        }
        
        return NO;
    };
    parserHelper.blockElementParsed = ^(NSDictionary* elementDescription)
    {
        blockStationReady(elementDescription);
    };
    
    parser.delegate = parserHelper;
    
    BOOL parsed = [parser parse];
    if(!parsed)
    {
        NSLog(@"Did not parsed downloaded XML with stations list");
    }
}

-(NSArray*)arrayOfStationUsageFromXMLData:(NSData*)retrievedData
{
    if(![retrievedData length])
    {
        return nil;
    }
    
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:retrievedData];
    
    NSMutableArray* resultCollected = [[NSMutableArray alloc]init];
    
    RDXmlParserHelper* parserHelper = [[RDXmlParserHelper alloc]init];
    parserHelper.blockElementStarted = ^(NSString* elementName)
    {
        if([elementName isEqualToString:@"objStationData"])
        {
            return YES;
        }
        
        return NO;
    };
    parserHelper.blockElementParsed = ^(NSDictionary* elementDescription)
    {
        [resultCollected addObject:elementDescription];
    };
    
    parser.delegate = parserHelper;
    
    BOOL parsed = [parser parse];
    if(!parsed)
    {
        NSLog(@"Did not parsed downloaded XML with station usage list");
    }
    
    NSLog(@"Station usage: [%@].",resultCollected);
    
    return resultCollected;
}

#pragma mark Allocation and Deallocation
-(id)init
{
    self = [super init];
    
    return self;
}

#pragma mark Public interface
-(void)downloadDescriptionsForAllStationsWithCompletionBlock:(void(^)(BOOL completed, NSError* error))block withStationDownloadedBlock:(void(^)(NSDictionary* stationDescription))blockStationReady
{
    NSURL *url = [NSURL URLWithString:@"http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [myFetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
        
        if (error != nil)
        {
            // status code or network error
            block(NO,error);
            
        } else {
            
            //parse downloaded XML
            [self stationsDescriptionsFromXML:retrievedData withStationDownloadedBlock:blockStationReady];
            
            // succeeded
            block(YES,nil);
            
        }
    }];
}

-(void)downloadTrainMovementInfoForTrainWithId:(NSString*)trainId withCompletionBlock:(void(^)(NSDictionary* trainMovementDescription, BOOL completed))block
{
#warning Implement downloadTrainMovementInfoForTrainWithId
}

-(void)downloadStationUsageForStation:(NSString*)station withCompletionBlock:(void(^)(NSArray* stationUsageDescriptions, BOOL completed))block
{
    station = [station stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString* stringUrl = [NSString stringWithFormat:@"http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=%@",station];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [myFetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
        
        if (error != nil)
        {
            NSLog(@"Error downloading usage: [%@]",error);
            
            // status code or network error
            block(nil,NO);
            
        } else {
            
            //parse downloaded XML
            block([self arrayOfStationUsageFromXMLData:retrievedData],YES);
            
        }
    }];
}

@end
