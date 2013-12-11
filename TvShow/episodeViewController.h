//
//  episodeViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "episode.h"
@interface episodeViewController : UITableViewController


// Properties for showing episodes

@property (nonatomic) NSMutableArray * episodes;
@property (nonatomic) NSString *cellTitle;

@end
