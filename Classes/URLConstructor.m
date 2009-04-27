//
//  URLConstructor.m
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "URLConstructor.h"
#import "LOE.h"

@implementation URLConstructor

+(NSURL *)urlForResourceType:(NSString *)resourceType loeDictionary:(NSDictionary *)loeDict {
	
	//We will find a better way to deal with special cases later ...
	//Some resources have easy URLs so you can map to them directly e.g. MeshObjects
	//Others are user specific so you have to check the dictionary for them first e.g. ContactsLink ...
	NSString * resourceString;
	
	if([resourceType isEqualToString:MESHOBJECTS])
		resourceString = resourceType;
	else
		resourceString = [loeDict valueForKey:resourceType];
		
	NSString * urlString = [NSString stringWithFormat:@"%@%@", [loeDict valueForKey:BaseURI], resourceString];
	return [NSURL URLWithString:urlString];
}




-(NSURL *)urlForResourceType:(NSString *)resourceType loeDictionary:(NSDictionary *)loeDict {
	NSString * urlString = [NSString stringWithFormat:@"%@%@", [loeDict valueForKey:BaseURI], [loeDict valueForKey:resourceType]];
	return [NSURL URLWithString:urlString];
}




-(void) dealloc {
	[super dealloc];
}
@end
