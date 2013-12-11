//
//  GetEpisodes.m
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "GetEpisodes.h"

@implementation GetEpisodes

@synthesize seriesID;
@synthesize delegate;
@synthesize episodes;
@synthesize currentEpisode;
@synthesize currentElementValue;

-(void)main {
    
    
    // Assignment of required string variables
    // A url is created by encoding and appending the search term.
    NSString *apikey = @"0182647533561FAB";
    NSString *series_ID = [seriesID stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://thetvdb.com/api/%@/series/%@/all/en.xml",apikey, series_ID];
    
    // Although NSURLSession is the preferred way of fetching data in iOS7
    // This class makes use of the NSURLConnection to support backwards compatability
    // NSURLConnection downloads the contents of a url to memory.
    // NSURLConnection supports retrival via completion handler block, via delegate, or synchronously.
    // No post data needs to be sent, nor does the connection need to be monitored
    // As such, this program uses a synchronous request via sendSynchronousRequest.
    // This method is usually only recoommened when the developer ensures it runs in an independant thread.
    // Error Handling is implemented manually inside the class, and error checking in carried out in
    // Individual view controllers manually also.
    // A grand central dispatch queue is used to separate the thread.
    
    
    // New instance variable queue, fetch one of apples default queues, runs a block of code.
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundQueue, ^{
        
        // Create the URL request
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        // Create a data object to store the recieved data.
        NSData *responseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
        
        // If URL request is successful
        if (responseData != nil) {
            // NSError *error = nil;
            
            // The XML is parsed used NSXMLParser, a easy to use SAX parser that parses the document bit by bit than as a whole.
            // The parser machine is created and initialised using the data object from the API.
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:responseData];
            
            // Basic Setup.
            [xmlParser setDelegate:self];
            [xmlParser setShouldResolveExternalEntities:NO];
            
            // Parse the document.
            BOOL ok = [xmlParser parse];
            
            // Error Checking.
            if (!ok) {
                
                [delegate serviceFinished:self withError:YES];
            }

            [delegate serviceFinished:self withError:NO];
            
            
        }
        // If URL request not successful
        else {
            [delegate serviceFinished:self withError:YES];
        }
    });
}

// Code executed at start of parsing. Optional.
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"Did start parsing");
}

// Code executed at end of parsing. Optional.
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Did finish parsing");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if( [elementName isEqualToString:@"Data"]){
       // NSLog(@"Did Start Data");
       episodes = [[NSMutableArray alloc] init];
    }
    if( [elementName isEqualToString:@"Episode"]){
       // NSLog(@"Did Start Episode");
        self.currentEpisode = [[episode alloc] init];
    }
    
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] init];
    }
    if ([string isEqualToString:@"\n"]) {
        // Do nothing
    }
    else {
        currentElementValue = [NSMutableString stringWithFormat:@"%@%@",currentElementValue,string];
    }
    
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"Data"]){
        // End of XML reached.
        NSLog(@"End of XML");
    }
    else if( [elementName isEqualToString:@"id"]){
        
        self.currentEpisode.episodeID = currentElementValue;
        
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Combined_episodenumber"]){
        
        [currentElementValue replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [currentElementValue length])];
        [currentElementValue replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [currentElementValue length])];        self.currentEpisode.episodeNumber = [currentElementValue intValue];
        currentElementValue = nil;
    }
    else if ( [elementName isEqualToString:@"Combined_season"]) {
        
        // The value must be converted to int, but first spaces and new lines need to be removed.
        [currentElementValue replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [currentElementValue length])];
        [currentElementValue replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [currentElementValue length])];
        self.currentEpisode.seasonNumber = [currentElementValue intValue];
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"EpisodeName"]){
        self.currentEpisode.episodeName = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Overview"]){
        self.currentEpisode.overview = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Rating"]){
        self.currentEpisode.rating = currentElementValue;
        
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"FirstAired"]){
        self.currentEpisode.airDate = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Episode"]){
        
        // End of object.
        [episodes addObject:currentEpisode];
        
        currentEpisode = nil;
        currentElementValue = nil;
    }
    else {
        currentElementValue = nil;
    }
}



@end