//
//  LOE.h
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebTestConstants.h"
#import "XMLParser.h"
#import "DataObjectConverter.h"
#import "URLConstructor.h"
#import "NetworkConnector.h"
#import "MeshObjectFactory.h"
#import "Resource.h"

@interface LOE : NSObject {
	
	NSString * authToken;
	NSString * _userID;
	id delegate;

	
	

	//LOE Dictionary for internal use it contains 
	//key-value pairs where key = current userID and value = NSMutableDictionary contain info associated
	//with the current user
	NSMutableDictionary * loeDict;
}

@property (nonatomic, retain) NSString * authToken;
@property (nonatomic, retain) id delegate;





-(BOOL)connectWithUserID:(NSString*)userID password:(NSString*)uPassword;
-(NSMutableURLRequest*)windowsLiveIDRequest;
-(NSMutableURLRequest*)cloeTopLevelRequest;
-(NSMutableURLRequest*)requestWithURL:(NSURL*)url 
							authToken:(NSString*)authT 
						 headerFields:(NSDictionary*)hFields 
							 HTTPVerb:(NSString*)verb 
							 HTTPBody:(NSData*)body;

-(id)syncFetchResource:(NSString *)resourceType;
-(void)asyncFetchResource:(NSString *)resourceType;

-(id)syncUpdateResource:(Resource *)resource;
@end
