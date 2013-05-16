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
-(NSArray*)stationsDescriptionsFromXML:(NSData*)retrievedData
{
    if(![retrievedData length])
    {
        return nil;
    }
    
    NSXMLParser* parser = [[NSXMLParser alloc]initWithData:retrievedData];
    
    RDXmlParserHelper* parserHelper = [[RDXmlParserHelper alloc]init];
    
    parser.delegate = parserHelper;
    
    BOOL parsed = [parser parse];
    if(!parsed)
    {
        NSLog(@"Did not parsed downloaded XML with stations list");
        return nil;
    }
    
    NSArray* parsedResult = [parserHelper parsedResult];
    
    return parsedResult;
}

#pragma mark Allocation and Deallocation

#pragma mark Public interface
-(void)downloadDescriptionsForAllStationsWithCompletionBlock:(void(^)(NSArray* stationsDescriptions, BOOL completed))block
{
    NSURL *url = [NSURL URLWithString:@"http://api.irishrail.ie/realtime/realtime.asmx/getAllStationsXML"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    GTMHTTPFetcher* myFetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [myFetcher beginFetchWithCompletionHandler:^(NSData *retrievedData, NSError *error) {
        
        if (error != nil)
        {
            // status code or network error
            block(nil,NO);
            
        } else {
            
            // succeeded
            block([self stationsDescriptionsFromXML:retrievedData],YES);
            
        }
    }];
}

-(void)downloadTrainMovementInfoForTrainWithId:(NSString*)trainId withCompletionBlock:(void(^)(NSDictionary* trainMovementDescription, BOOL completed))block
{
#warning Implement downloadTrainMovementInfoForTrainWithId
}

@end
