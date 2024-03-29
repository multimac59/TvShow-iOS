//
//  GetSeries.m
//  TvShow
//
//  Created by Shazib Hussain on 27/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "GetSeries.h"

@implementation GetSeries

@synthesize searchTerm;
@synthesize delegate;
@synthesize shows;
@synthesize series;
@synthesize currentElementValue;

-(void)main {
    
    
    NSLog(@"Service has run");
    
    // Assignment of required string variables, the API key is not used in the 'GetSeries' search requests.
    // A url is created by encoding and appending the search term.
    //NSString *apikey = @"0182647533561FAB";
    NSString *search_term = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://thetvdb.com/api/GetSeries.php?seriesname=%@", search_term];
    
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
        NSLog(@"Did Start Data");
        shows = [[NSMutableArray alloc] init];
    }
    if( [elementName isEqualToString:@"Series"]){
        self.series = [[tvseries alloc] init];
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
    // NSLog(@"string output: %@", currentElementValue);

}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"Data"]){
        // End of XML reached.
        NSLog(@"End of XML");
    }
    else if( [elementName isEqualToString:@"seriesid"]){
        self.series.seriesId = [NSString stringWithString:currentElementValue];
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"banner"]){
        self.series.banner = currentElementValue;
        currentElementValue = nil;
    }
    else if ( [elementName isEqualToString:@"SeriesName"]) {
        self.series.name = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"FirstAired"]){
        self.series.firstAired = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Network"]){
        self.series.network = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Overview"]){
        self.series.overview = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"IMDB_ID"]){
        self.series.imdb = currentElementValue;
        currentElementValue = nil;
    }
    else if( [elementName isEqualToString:@"Series"]){
        // End of object.
        [shows addObject:series];
        series = nil;
        currentElementValue = nil;
    }
    else {
        currentElementValue = nil;
    }
}



























@end
