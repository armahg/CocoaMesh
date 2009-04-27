//
//  DataToObjectConverter.m
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "DataObjectConverter.h"
#import "JSON.h"


@implementation DataObjectConverter


-(NSDictionary *)convertJSONToDict:(NSString *)json {
	SBJSON * s = [[[SBJSON alloc] init] autorelease];
	return (NSDictionary *)[s objectWithString:json error:nil];
}


+(id)convertJSONToDict:(NSString *)json {
	SBJSON * s = [[[SBJSON alloc] init] autorelease];
	id val =  [s objectWithString:json error:nil];
	return val;
}

+(NSString *)convertCollectionToJSON:(id)coll {
	return [coll JSONRepresentation];
}

-(void) dealloc {
	[super dealloc];
}

@end
