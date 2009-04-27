//
//  NetworkConnector.m
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "NetworkConnector.h"


@implementation NetworkConnector


-(NSData*)sendSynchronousRequest:(NSURLRequest *)request {
	
	NSURLResponse * response;	
	return [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
}


+ (NSData*)sendSynchronousRequest:(NSURLRequest *)request {
	NSURLResponse * response;	
	NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	
	NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
	NSLog(@"ALL RESPONSE HEADER FIELDS \n\n %@  STATUS CODE : %i\n\n", [httpResponse allHeaderFields], [httpResponse statusCode]);
	return data;
}

@end
