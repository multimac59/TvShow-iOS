//
//  GetEpisodes.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "episode.h"
#import "GetEpisodesDelegate.h"
@interface GetEpisodes : NSObject <NSXMLParserDelegate>{
    
    NSMutableString *currentElementValue;
    
    episode *currentEpisode;
    
    NSMutableArray *episodes;
    
    NSString *seriesID;
    
}
-(void) main;

@property (nonatomic, retain) NSString *seriesID;
@property (nonatomic, retain) id<GetEpisodesDelegate> delegate;
@property (nonatomic, retain) episode *currentEpisode;
@property (nonatomic, retain) NSMutableArray *episodes;
@property (nonatomic, retain) NSMutableString *currentElementValue;

@end
