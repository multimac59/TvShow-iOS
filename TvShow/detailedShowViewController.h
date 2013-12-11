//
//  detailedShowViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tvseries.h"

@interface detailedShowViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property IBOutlet UILabel *network;

@property IBOutlet UILabel *airDate;

@property (nonatomic) tvseries * series;

@property IBOutlet UITextView *overview;

@property IBOutlet UIImageView *banner;

@property IBOutlet UINavigationItem *navBar;

@property IBOutlet UIButton *imdb;

@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)LaunchURL;
- (void)addBtnClick;
- (void)shareText:(NSString *)string;
- (void)share;
@end
