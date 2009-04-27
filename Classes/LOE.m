//
//  LOE.m
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "LOE.h"


@interface LOE (PrivateMethods)

-(NSString *)getLiveIDHTTPBody;
-(id)setValue:(id)value forKeyInCurrentDict:(NSString *)key;
-(id)valueForKeyInCurrentDict:(NSString *)key;
-(NSMutableURLRequest *)typicalJSONGETRequest:(NSURL*)url;
-(NSMutableURLRequest *)typicalJSONPUTRequest:(NSURL*)url data:(NSData*)dat;
@end


@implementation LOE

@synthesize authToken;
@dynamic delegate;



-(id)valueForKeyInCurrentDict:(NSString *)key {
	NSMutableDictionary * curr = [loeDict valueForKey:_userID];
	return [curr valueForKey:key];
}

-(id)setValue:(id)value forKeyInCurrentDict:(NSString *)key {
	NSMutableDictionary * curr = [loeDict valueForKey:_userID];
	[curr setValue:value forKey:key];
	return [curr valueForKey:key];
}



-(NSString *)getLiveIDSOAPHTTPBody {
	NSNumber * rand = [NSNumber numberWithInt:( 10000 + (random()% (99999 - 10000)))];
	NSDate * current = [NSDate date];
	NSDate * currentPlusHour = [current addTimeInterval:3600];
	
	NSDictionary * currentDict = [loeDict valueForKey:_userID];
	
	NSString * soapMessage = [NSString stringWithFormat:LiveFrameworkSOAPTemplate,
							  APP_ID,
							  LiveSOAPURLEndPoint,
							  [rand stringValue],
							  [currentDict valueForKey:USERID],
							  [currentDict valueForKey:PASSWORD],
							  [current description],
							  [currentPlusHour description],
							  LiveFXDomain];
	
	return soapMessage;
}


-(id) init {
	self = [super init];
	if (self) {
		loeDict = [[NSMutableDictionary alloc] initWithCapacity:5];
	}
	return self;
}


-(BOOL)connectWithUserID:(NSString*)userID password:(NSString*)uPassword {
		
	if([loeDict valueForKey:userID] == nil) {
		NSMutableDictionary * dict = [NSMutableDictionary 
									  dictionaryWithObjectsAndKeys:userID, USERID, uPassword, PASSWORD, nil];
		[loeDict setValue:dict forKey:userID];
		_userID = [NSString stringWithString:userID];
	}
	
	//Switch to using NetworkConnector later
	//First connect to Windows LIVE ID for authToken
	NSURLResponse * liveIDResponse;
	NSData * liveIDResponseBody = [NSURLConnection sendSynchronousRequest:[self windowsLiveIDRequest] 
														returningResponse:&liveIDResponse 
																	error:nil];
	NSString * liveIDResponseString = [[[NSString alloc] initWithData:liveIDResponseBody encoding:NSUTF8StringEncoding] autorelease];
	XMLParser * p = [[[XMLParser alloc] init] autorelease];
	self.authToken = [p parseXML:liveIDResponseString forElementContents:BINARYTOKEN];
	NSLog(@"Done parsing authtoKen");
	NSLog(self.authToken);
	if (self.authToken == nil || [self.authToken isEqualToString:@""])
		return NO;
	
	
	
	//Now connect to CLOE for top level Mesh stuff
	NSURLResponse * cloeResponse;
	NSData * cloeTopLevelResponseBody = [NSURLConnection sendSynchronousRequest:[self cloeTopLevelRequest] 
															  returningResponse:&cloeResponse 
																		  error:nil];
	DataObjectConverter * d = [[[DataObjectConverter alloc] init] autorelease];
	NSString * cloeResponseString = [[[NSString alloc] initWithData:cloeTopLevelResponseBody encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary * topLevelDict = [d convertJSONToDict:cloeResponseString];
	NSLog(@"Done parsing topLevelDict");
	NSLog(@"%@", [topLevelDict description]);
	if (topLevelDict == nil)
		return NO;
	
	
	
	
	//Save the returned Info in the appropriate dict
	for (NSString * key in topLevelDict) {
		[self setValue:[topLevelDict valueForKey:key] forKeyInCurrentDict:key];
	}
	
	
	return YES;
}

-(NSMutableURLRequest *)typicalJSONPUTRequest:(NSURL*)url data:(NSData*)dat {
	NSDictionary * hFields = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", CONTEN_TYPE,
							  @"application/json", ACCEPT, LiveFXDomain, HOST, nil];
	
	return [self requestWithURL:url 
					  authToken:self.authToken 
				   headerFields:hFields 
					   HTTPVerb:HTTP_PUT
					   HTTPBody:dat];
}

-(NSMutableURLRequest *)typicalJSONGETRequest:(NSURL*)url {
	NSDictionary * hFields = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", CONTEN_TYPE,
							  @"application/json", ACCEPT, LiveFXDomain, HOST, nil];
	
	return [self requestWithURL:url 
					  authToken:self.authToken 
				   headerFields:hFields 
					   HTTPVerb:HTTP_GET HTTPBody:nil];
}

-(NSMutableURLRequest*)requestWithURL:(NSURL*)url 
							authToken:(NSString*)authT 
						 headerFields:(NSDictionary*)hFields 
							 HTTPVerb:(NSString*)verb 
							 HTTPBody:(NSData*)body {
	
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:verb];
	[request setHTTPBody:body];
	
	for (NSString * hfield in [hFields allKeys]) {
		[request setValue:[hFields valueForKey:hfield] forHTTPHeaderField:hfield];
	}
	
	[request setValue:authT forHTTPHeaderField:HTTP_AUTHORIZATION];
	
	return request;
}



-(NSMutableURLRequest*)windowsLiveIDRequest {
	
	NSString * soapMessage = [self getLiveIDSOAPHTTPBody];	
	NSDictionary * hFields = [NSDictionary dictionaryWithObjectsAndKeys:@"application/soap+xml; charset=utf-8", CONTEN_TYPE,
	[NSString stringWithFormat:@"%d",[soapMessage length]], CONTENT_LENGTH, nil];
	
	return [self requestWithURL:[NSURL URLWithString:LiveSOAPURLEndPoint] 
					  authToken:nil 
				   headerFields:hFields 
					   HTTPVerb:HTTP_POST 
					   HTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
}

	
-(NSMutableURLRequest*)cloeTopLevelRequest {
	NSDictionary * hFields = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", CONTEN_TYPE,
							  @"application/json", ACCEPT, LiveFXDomain, HOST, nil];
	
	return [self requestWithURL:[NSURL URLWithString:LiveFXBaseURI] 
					  authToken:self.authToken 
				   headerFields:hFields 
					   HTTPVerb:HTTP_GET HTTPBody:nil];
}

-(id)delegate {
	return [self valueForKeyInCurrentDict:DELEGATE];
}

-(void) setDelegate:(id)newDelegate {
	delegate = [self setValue:newDelegate forKeyInCurrentDict:DELEGATE];
}





-(id)syncFetchResource:(NSString *)resourceType {
	//URLConstructor creates resource url
	NSURL * url = [URLConstructor urlForResourceType:resourceType loeDictionary:[loeDict valueForKey:_userID]];
	NSLog([url description]);
	
	//NetworkConnecter fetches resource using NSURLRequest
	NSURLRequest * request = [self typicalJSONGETRequest:url];
	NSData * responseData = [NetworkConnector sendSynchronousRequest:request];
	NSString * responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(responseString);
	
	
	//DataToObjectConverter converts returned data to appropriate object
	id contacts = [DataObjectConverter convertJSONToDict:responseString];
	//NSLog(@"Printing Contacts Description %@",[contacts description]);
	
	
	
	id contactObjects = [MeshObjectFactory objectForResourceType:resourceType usingData:contacts];
	//NSLog(@"Printing contact objects %@", [contactObjects description]);
	
	
	/*
	 New pland
	 Have a MeshObjectFactory that creates and returns objects based on passed in strings. Try and use a switch statement for efficiency.
	 
	 The init method for MeshObjects loops through and does a setKey forValue on the object properties.
	 
	 Figure out multi threading issues ... use instances and create and release as needed? C functionS?
	 
	 Keeping track of updates to Meshobjects .... is that necessary? KeyValue observing perhaps? Someway of just marking those
	 properties that have been changed?
	 
	 The rest should be fairly easy ... aim to get things done / cleaned up by end of this week
	 
	 */
	
	
	return contactObjects;
}


-(void)asyncFetchResource:(NSString *)resourceType {

}



-(id)syncUpdateResource:(Resource *)resource {
	//Convert to data structure
	NSDictionary * rDict = [resource convertToCollection];
	NSString * json = [DataObjectConverter convertCollectionToJSON:rDict];
	NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
							   
		
	//create PUT request
	NSString * linkString = [NSString stringWithFormat:@"%@%@", [rDict valueForKey:BaseURI], [rDict valueForKey:SELFLINK]];
	NSURL * url = [NSURL URLWithString:linkString];
	NSURLRequest * request = [self typicalJSONPUTRequest:url data:jsonData];
	
	//do synchronous request
	NSString * responseString = [[[NSString alloc] initWithData:[NetworkConnector sendSynchronousRequest:request] 
													   encoding:NSUTF8StringEncoding] autorelease];
	
	//get results check for error etc.
	NSLog(responseString);
	return nil;
}


- (void)dealloc {
	[loeDict release];
	[super dealloc];
}

@end
