//
//  RDXmlParserHelper.h
//  IrishTrains
//
//  Created by Oleksiy Ivanov on 5/17/13.
//  Copyright (c) 2013 Oleksiy Ivanov.
//  The MIT License (MIT).
//

#import <Foundation/Foundation.h>

@interface RDXmlParserHelper : NSObject<NSXMLParserDelegate>

@property(strong) void(^blockElementParsed)(NSDictionary *elementDescription);
@property(strong) BOOL(^blockElementStarted)(NSString *elementName);
@property(strong)NSMutableDictionary * tmpDictionary;
@property(strong)NSString * currentRootElementName;
@property(strong)NSString * currentElementName;

- (id)parsedResult;

@end
