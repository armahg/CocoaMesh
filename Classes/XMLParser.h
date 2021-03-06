//
//  XMLParser.h
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParser : NSObject {
	NSXMLParser * parser;
	NSString * parsingElement;
	BOOL parsingAuthToken;
	NSMutableString * authToken;
	NSCondition * authCondidion;
}

@property(nonatomic, retain) NSXMLParser * parser;


-(NSString *)parseXML:(NSString*)xml forElementContents:(NSString*)elementName;
@end
