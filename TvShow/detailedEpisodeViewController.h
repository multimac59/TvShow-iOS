//
//  detailedEpisodeViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>

// import the episode class to carry over an instance of epsiode
#import "episode.h"

@interface detailedEpisodeViewController : UIViewController

@property episode * targetEpisode;

@property NSString *season;

@property (weak, nonatomic) IBOutlet UILabel *seasonLbl;

@property (weak, nonatomic) IBOutlet UILabel *episodeLbl;

@property (weak, nonatomic) IBOutlet UIImageView *banner;

@property (weak, nonatomic) IBOutlet UILabel *airDateLbl;

@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;

@property (weak, nonatomic) IBOutlet UITextView *overviewTxt;



@end
