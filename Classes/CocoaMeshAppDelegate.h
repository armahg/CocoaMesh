//
//  CocoaMeshAppDelegate.h
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright Lafayette College 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CocoaMeshAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

