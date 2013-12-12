//
//  detailedShowViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>

// Importing the required files
#import "tvseries.h"
#import "GetEpisodesDelegate.h"
#import "tvshowAppDelegate.h"
#import "SeriesEntity.h"
#import "GetEpisodes.h"
#import "episodeViewController.h"
#import "PKRevealController.h"

// This controlled is a delegate for the tableview and for GetEpisode.

@interface detailedShowViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GetEpisodesDelegate>


// These IBOutlets are all used to assign values on the view
@property IBOutlet UILabel *network;

@property IBOutlet UILabel *airDate;

@property IBOutlet UITextView *overview;

@property IBOutlet UIImageView *banner;

@property IBOutlet UINavigationItem *navBar;

@property IBOutlet UIButton *imdb;

// This IBOutlet connects the tableview
@property IBOutlet UITableView *table;

// This property is used for Core Data
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

// These properties are used for store episodes recieved from GetEpisodes and for splitting the episodes into seasons
// GetEpisode only returns a single array of episodes, these are split into seasons within the view controllers code
@property (nonatomic) tvseries * series;
@property (nonatomic) NSMutableArray * episodes;
@property NSMutableDictionary *seasonsDict;
@property (nonatomic) int numberOfSeasons;

// These are various methods to do with buttons on the view
- (void)LaunchURL;
- (void)addBtnClick;
- (void)shareText:(NSString *)string;
- (void)share;

@end
