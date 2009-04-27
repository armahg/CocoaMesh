//
//  MeshObjectFactory.m
//  CocoaMesh
//
//  Created by George  Armah on 4/21/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "MeshObjectFactory.h"
#import "CocoaMesh.h"

@interface MeshObjectFactory ()

+(NSArray *)createContactsArray:(NSArray *)contactsData;
+(NSArray *)createMeshObjectsArray:(NSArray *)meshObjectsData;
@end




@implementation MeshObjectFactory

static NSMutableDictionary * meshObjectDict = nil;

+ (NSMutableDictionary*)sharedMeshObjectDict {
	if (meshObjectDict == nil) {
		meshObjectDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
						  [NSNumber numberWithInt:CONTACTSNUM], CONTACTS,
						  [NSNumber numberWithInt:MESHNUM], MESH,
						  [NSNumber numberWithInt:SCRIPTNUM], SCRIPT,
						  [NSNumber numberWithInt:PROFILESNUM], PROFILES,
						  [NSNumber numberWithInt:MESHOBJECTSNUM], MESHOBJECTS,
						  nil];
	}
	return meshObjectDict;
}

//Need a way to have one generic method that creates an array and then dynamically determine the type
//after the if clause
+(NSArray *)createContactsArray:(NSArray *)contactsData {
	id contactDict;
	NSMutableArray * contactsArray = [[NSMutableArray alloc] initWithCapacity:[contactsData count]];
	
	for (contactDict in contactsData) {
		
		if([contactDict isKindOfClass:[NSDictionary class]])
			[contactsArray addObject:[[[Contact alloc] initWithResource:contactDict] autorelease]];
	}
	
	return contactsArray;
}

+(NSArray *)createMeshObjectsArray:(NSArray *)meshObjectsData {
	id mObjectDict;
	NSMutableArray * meshObjectsArray = [[NSMutableArray alloc] initWithCapacity:[meshObjectsData count]];
	
	for (mObjectDict in meshObjectsData) {
		
		if([mObjectDict isKindOfClass:[NSDictionary class]])
			[meshObjectsArray addObject:[[[MeshObject alloc] initWithResource:mObjectDict] autorelease]];
	}
	
	return meshObjectsArray;
}


+(id) objectForResourceType:(NSString *)rType usingData:(id)data {
	int val = [[[MeshObjectFactory sharedMeshObjectDict] valueForKey:rType] intValue];
	
	switch (val) {
			
		case CONTACTSNUM:
			return [MeshObjectFactory createContactsArray:(NSArray*)[data valueForKey:ENTRIES]];
			break;
			
		case MESHOBJECTSNUM:
			return [MeshObjectFactory createMeshObjectsArray:(NSArray*)[data valueForKey:ENTRIES]];
			break;
		default:
			return nil;
			break;
	}
}
					
					
@end
