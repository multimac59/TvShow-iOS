//
//  searchViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "detailedShowViewController.h"

// Importing the web service to perform the search
#import "GetSeriesDelegate.h"
#import "GetSeries.h"

// This controller searches for tv shows

@interface searchViewController : UITableViewController <UISearchBarDelegate, GetSeriesDelegate> // Setup delegates

@property (nonatomic, retain) IBOutlet UISearchBar *filmSearch; //Search bar outlet

// Various tableview properties

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic) int atIndex;

@property (nonatomic) UIActivityIndicatorView *progress;

// Method for menu button to reveal left controller

- (void)toggleTray:(id)sender;

@end
