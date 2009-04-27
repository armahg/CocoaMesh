//
//  NetworkConnector.h
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkConnector : NSObject {

}


-(NSData*)sendSynchronousRequest:(NSURLRequest *)request;
+(NSData*)sendSynchronousRequest:(NSURLRequest *)request;

@end
