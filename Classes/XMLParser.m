//
//  XMLParser.m
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser

@synthesize parser;

-(id) init {
	self = [super init];
	if (self) {
		parsingElement = nil;
		authToken = nil;
		authCondidion = [[[NSCondition alloc] init] autorelease];
	}
	return self;
}

-(NSString *)parseXML:(NSString*)xml forElementContents:(NSString*)elementName {
	if (parsingElement != nil){
		[parsingElement release];
	}
	parsingElement = [elementName copy];
	
	if (parser != nil) {
		[parser release];
	}
	parser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
	[parser setDelegate:self];
	[parser parse];
	
	[authCondidion lock];
	while (parsingAuthToken) {
		[authCondidion wait];
	}
	[authCondidion unlock];
	
	return authToken;
}

- (void)  parser:(NSXMLParser *)par 
 didStartElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
   qualifiedName:(NSString *)qualifiedName 
	  attributes:(NSDictionary *)attributeDict {
	
	
	if ([elementName isEqualToString:parsingElement]) {
		parsingAuthToken = YES;
		//NSLog(@"Found %@", elementName);
	}
	
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
    if (parsingAuthToken) {
		if (!authToken) {
			authToken = [[NSMutableString alloc] initWithCapacity:200];
		}
		[authToken appendString:string];
    }
}

- (void)  parser:(NSXMLParser *)parser 
   didEndElement:(NSString *)elementName 
	namespaceURI:(NSString *)namespaceURI 
   qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:parsingElement]) {
		[authCondidion lock];
		//NSLog(@"Finished Parsing authToken %@", authToken);
		parsingAuthToken = !parsingAuthToken;
		[authCondidion signal];
		[authCondidion unlock];
	}
	
}



-(void) dealloc {
	if (parsingElement)
		[parsingElement release];
	if (parser)
		[parser release];
	[super dealloc];
}

@end
