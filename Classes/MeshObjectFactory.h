//
//  MeshObjectFactory.h
//  CocoaMesh
//
//  Created by George  Armah on 4/21/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebTestConstants.h"



@interface MeshObjectFactory : NSObject {

}

+(id) objectForResourceType:(NSString *)rType usingData:(id)data;
+ (NSMutableDictionary*)sharedMeshObjectDict;

@end
