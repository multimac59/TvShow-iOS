//
//  detailedShowViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tvseries.h"
#import "GetEpisodesDelegate.h"
@interface detailedShowViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GetEpisodesDelegate>

@property IBOutlet UILabel *network;

@property IBOutlet UILabel *airDate;

@property (nonatomic) tvseries * series;

@property IBOutlet UITextView *overview;

@property IBOutlet UIImageView *banner;

@property IBOutlet UINavigationItem *navBar;

@property IBOutlet UIButton *imdb;

@property IBOutlet UITableView *table;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) NSMutableArray * episodes;


@property NSMutableDictionary *seasonsDict;

@property (nonatomic) int numberOfSeasons;
- (void)LaunchURL;
- (void)addBtnClick;
- (void)shareText:(NSString *)string;
- (void)share;
@end
