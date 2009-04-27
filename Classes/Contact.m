//
//  Contact.m
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import "Contact.h"


@implementation Contact


@synthesize ProfilesLink;
@synthesize DisplayName;





- (void)dealloc {
	[DisplayName release];
	[ProfilesLink release];
	[super dealloc];
}


@end
