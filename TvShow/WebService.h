//
//  WebService.h
//  TvShow
//
//  Created by Shazib Hussain on 26/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject

@property NSString *searchTerm; // Search term passed from search bar
@property NSData *results; // NSData to store results
@property BOOL error; // For error handling

- (void) getData;
@end
