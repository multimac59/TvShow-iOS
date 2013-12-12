//
//  favouritesViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favouritesViewController : UITableViewController

// Various propertires for managing the table

@property NSMutableArray * valuesForTable;

@property (nonatomic) int atIndex;

// Accessing the core data store
@property (nonatomic) NSManagedObjectContext *managedObjectContext;


- (void)toggleTray:(id)sender;

@end
