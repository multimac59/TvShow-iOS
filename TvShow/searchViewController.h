//
//  searchViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailedShowViewController.h"

@interface searchViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *filmSearch;


@property (nonatomic, strong) NSMutableArray *series;

@property (nonatomic) int atIndex;

@end
