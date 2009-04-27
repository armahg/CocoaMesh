//
//  CocoaMeshAppDelegate.m
//  CocoaMesh
//
//  Created by George  Armah on 4/11/09.
//  Copyright Lafayette College 2009. All rights reserved.
//

#import "CocoaMeshAppDelegate.h"
#import "RootViewController.h"
#import "CocoaMesh.h"



@implementation CocoaMeshAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	
	LOE * env = [[LOE alloc] init];
	[env connectWithUserID:@"" password:@""];



	NSArray * meshObjs = [env syncFetchResource:MESHOBJECTS];
	MeshObject * m = [meshObjs objectAtIndex:0];
	NSLog(@"RESOURCE DATA 1  \n\n  %@", m.resourceData);
	
	[m setValue:[[NSDate date] description] forKey:@"Title"];
	[env syncUpdateResource:m];
	
	MeshObject * m2 = [[env syncFetchResource:MESHOBJECTS] objectAtIndex:0];
	NSLog(@"RESOURCE DATA 2 ... Check for Title CHANGE !! :)  \n\n  %@", m2.resourceData);
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
