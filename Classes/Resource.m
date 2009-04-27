//
//  Resource.m
//  CocoaMesh
//
//  Created by George  Armah on 4/23/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "Resource.h"


@implementation Resource


@synthesize resourceData;

-(id)initWithResource:(NSDictionary *)resource {
	
	if(self = [super init]) {
		NSString * key;
		resourceData = [[NSMutableDictionary alloc] initWithCapacity:20];
		for (key in resource) {
			[self setValue:[resource valueForKey:key] forKey:key];
		}
	}
	
	return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
	[self.resourceData setValue:value forKey:key];
}


//For now this method is written just for contactData
-(id)convertToCollection {
	
	unsigned int outCount, i;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	NSMutableDictionary * dict = [[[NSMutableDictionary alloc] initWithCapacity:outCount] autorelease];
	
	for(i = 0; i < outCount; i++) {
		objc_property_t property = properties[i];
		const char *propName = property_getName(property);
		if(propName) {
			NSString *propertyName = [NSString stringWithUTF8String:propName];
			[dict setValue:[self valueForKey:propertyName]  forKey:propertyName];

		}
	}
	
	
	NSMutableDictionary * d = [[NSMutableDictionary alloc] initWithDictionary:self.resourceData];
	for (id k in dict) {
		if(![k isEqualToString:RESOURCEDATA])
			[d setValue:[dict valueForKey:k] forKey:k];
	}
	
	//NSLog(@"\n\n%@\n\n%@\n\n", [d description], [dict description]);
	free(properties);
	return d;
}


- (void)dealloc {
	[resourceData release];
	[super dealloc];
}

@end
