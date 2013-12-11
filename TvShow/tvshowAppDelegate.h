//
//  tvshowAppDelegate.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tvseries.h"
#import "SeriesEntity.h"

@interface tvshowAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


// Core Data Properties and Methods
@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Attempting PKReveal
@property UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
//- (BOOL) seriesDoesExist:(NSString *)seriesID;
//- (BOOL) addObjectToStore:(tvseries *)series;
@end
