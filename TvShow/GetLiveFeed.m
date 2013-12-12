//
//  GetLiveFeed.m
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "GetLiveFeed.h"

@implementation GetLiveFeed

@synthesize delegate;
@synthesize currentElementValue;
@synthesize episodes;
@synthesize currrentepisode;

-(void)main {
    
         NSString *url = [NSString stringWithFormat:@"http://services.tvrage.com/feeds/fullschedule.php?country=UK"];
    
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
            NSLog(@"finished without error");
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
    
    // If element Schedule is startes, init the array
    if( [elementName isEqualToString:@"schedule"]){
        
        episodes = [[NSMutableArray alloc] init];
    }
    if ([elementName isEqualToString:@"show"]) {
        self.currrentepisode = [[episode alloc]init];
        self.currrentepisode.episodeName = [attributeDict valueForKey:@"name"];
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
    
    if ( [elementName isEqualToString:@"schedule"]){
        NSLog(@"End of XML");
    }
    else if ([elementName isEqualToString:@"title"])
    {
        self.currrentepisode.airDate = currentElementValue;
    }
    else if ([elementName isEqualToString:@"show"])
    {
        [episodes addObject:currrentepisode];
        currrentepisode = nil;
        currentElementValue = nil;
    }
    else {
        currentElementValue = nil;
    }
}



@end
