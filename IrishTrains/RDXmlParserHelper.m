//
//  RDXmlParserHelper.m
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov. All rights reserved.
//

#import "RDXmlParserHelper.h"

@implementation RDXmlParserHelper


#pragma mark Public interface
-(id)parsedResult
{
    return nil;
}

#pragma mark NSXMLParserDelegate methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if(!self.tmpDictionary)
    {
        if(self.blockElementStarted(elementName))
        {
            self.currentRootElementName = elementName;
            self.tmpDictionary = [[NSMutableDictionary alloc]init];
        }
    }
    else
    {
        self.currentElementName = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:self.currentRootElementName])
    {
        self.blockElementParsed(self.tmpDictionary);
        self.tmpDictionary = nil;
        self.currentRootElementName = nil;
        self.currentElementName = nil;
    }
    else
    {
        self.currentElementName = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.tmpDictionary)
    {
        if([string length])
        {
            if(self.currentElementName)
            {
                [self.tmpDictionary setObject:string forKey:self.currentElementName];
            }
        }
    }
}

@end
