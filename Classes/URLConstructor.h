//
//  URLConstructor.h
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LOE;

@interface URLConstructor : NSObject {

}

-(NSURL *)urlForResourceType:(NSString *)resourceType loeDictionary:(NSDictionary *)loeDict;
+(NSURL *)urlForResourceType:(NSString *)resourceType loeDictionary:(NSDictionary *)loeDict;


@end
