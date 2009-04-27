//
//  Resource.h
//  CocoaMesh
//
//  Created by George  Armah on 4/23/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "WebTestConstants.h"

@interface Resource : NSObject {
	NSMutableDictionary * resourceData;
}


@property (nonatomic, retain) NSMutableDictionary * resourceData;


-(id)convertToCollection;
-(id)initWithResource:(NSDictionary *)resource;



@end
