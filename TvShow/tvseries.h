//
//  tvseries.h
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tvseries : NSObject <NSCoding> 

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *seriesId;

@property (nonatomic, copy) NSString *banner;

@property (nonatomic, copy) NSString *firstAired;

@property (nonatomic, copy) NSString *network;

@property (nonatomic, copy) NSString *overview;

@property (nonatomic, copy) NSString *imdb;


@end
