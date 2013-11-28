//
//  detailedShowViewController.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tvseries.h"

@interface detailedShowViewController : UIViewController

@property int index;

@property (nonatomic) tvseries * series;

@property IBOutlet UITextView *overview;

@property IBOutlet UIImageView *banner;

@end
