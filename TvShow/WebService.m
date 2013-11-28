//
//  WebService.m
//  TvShow
//
//  Created by Shazib Hussain on 26/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//
// The Web Service has to deal with different types of data, JSON, XML.
// As such complex proceedures are carried out in classes.
#import "WebService.h"

// Importing GCD
#import <dispatch/dispatch.h>

@implementation WebService

@synthesize searchTerm;
@synthesize results;
@synthesize error;

- (void)main {
    
    // Debugging output
    NSLog(@"Web Service Called");
    
}

- (void) getData {
    
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
        
        // Basic error handling to check if the value returned nil.
        if (responseData != nil) {
            
            self.results = responseData;
            self.error = NO;
        }
        else {
            // Set the error BOOL to YES is the resulting data is null
            self.error = YES;
        }
    });
}

@end
