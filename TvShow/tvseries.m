//
//  tvseries.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "tvseries.h"

@implementation tvseries

@synthesize seriesId;
@synthesize name;
@synthesize banner;
@synthesize firstAired;
@synthesize network;
@synthesize imdb;
@synthesize overview;

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:seriesId forKey:@"seriesId"];
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:banner forKey:@"banner"];
    [aCoder encodeObject:firstAired forKey:@"firstAired"];
    [aCoder encodeObject:network forKey:@"network"];
    [aCoder encodeObject:imdb forKey:@"imdb"];
    [aCoder encodeObject:overview forKey:@"overview"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]){
    self.seriesId = [aDecoder decodeObjectForKey:@"seriesId"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.banner = [aDecoder decodeObjectForKey:@"banner"];
    self.firstAired = [aDecoder decodeObjectForKey:@"firstAired"];
    self.network = [aDecoder decodeObjectForKey:@"network"];
    self.imdb = [aDecoder decodeObjectForKey:@"imdb"];
    self.overview = [aDecoder decodeObjectForKey:@"overview"];
    }
    return self;
}

@end
