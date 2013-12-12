//
//  searchViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailedShowViewController.h"


#import "GetSeriesDelegate.h"
#import "GetSeries.h"

@interface searchViewController : UITableViewController <UISearchBarDelegate, GetSeriesDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *filmSearch;

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic) int atIndex;

@property (nonatomic) UIActivityIndicatorView *progress;

- (void)toggleTray:(id)sender;

@end
