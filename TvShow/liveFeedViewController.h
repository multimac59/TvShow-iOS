//
//  liveFeedViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetLiveFeedDelegate.h"
#import "GetLiveFeed.h"

@interface liveFeedViewController : UITableViewController <GetLiveFeedDelegate>

// Properties to view the live feed

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (nonatomic) int atIndex;

@property (nonatomic) UIActivityIndicatorView *progress;

// Reveal controller method

- (void)toggleTray:(id)sender;
@end
