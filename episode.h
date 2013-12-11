//
//  episode.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface episode : NSObject

@property NSString * episodeID;

@property int seasonNumber;

@property int episodeNumber;

@property NSString *overview;

@property NSString *episodeName;

@property NSString *airDate;

@property NSString *rating;


@end
