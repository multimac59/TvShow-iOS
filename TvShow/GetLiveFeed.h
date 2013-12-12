//
//  GetLiveFeed.h
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetLiveFeedDelegate.h"
#import "episode.h"

@interface GetLiveFeed : NSObject  <NSXMLParserDelegate>{
    
    NSMutableString *currentElementValue;
    
}
-(void) main;

@property (nonatomic, retain) id<GetLiveFeedDelegate> delegate;
@property (nonatomic, retain) NSMutableString *currentElementValue;
@property (nonatomic, retain) episode *currrentepisode;
@property (nonatomic, retain) NSMutableArray *episodes;

@end
