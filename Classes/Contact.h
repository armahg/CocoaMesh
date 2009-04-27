//
//  Contact.h
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Resource.h"

@interface Contact : Resource {

	NSString * DisplayName;
	NSString * ProfilesLink;

}




@property (nonatomic, retain) NSString * DisplayName;
@property (nonatomic, readonly) NSString * ProfilesLink;

@end
