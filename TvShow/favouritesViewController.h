//
//  favouritesViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favouritesViewController : UITableViewController

@property NSMutableArray * valuesForTable;

@property (nonatomic) int atIndex;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
