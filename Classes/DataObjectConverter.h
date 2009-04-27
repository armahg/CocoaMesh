//
//  DataToObjectConverter.h
//  CocoaMesh
//
//  Created by George  Armah on 4/12/09.
//  Copyright 2009 Lafayette College. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataObjectConverter : NSObject {

}


-(NSDictionary *)convertJSONToDict:(NSString *)json;
+(id)convertJSONToDict:(NSString *)json;
+(NSString *)convertCollectionToJSON:(id)coll;
@end
