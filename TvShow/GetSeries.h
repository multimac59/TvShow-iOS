//
//  GetSeries.h
//  TvShow
//
//  Created by Shazib Hussain on 27/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetSeriesDelegate.h"
#import "tvseries.h"

@interface GetSeries : NSObject <NSXMLParserDelegate>{
    
    NSMutableString *currentElementValue;
    
    tvseries *series;
    
    NSMutableArray *shows;
    
    NSString *searchTerm;
    
}
-(void) main;

@property (nonatomic, retain) NSString *searchTerm;
@property (nonatomic, retain) id<GetSeriesDelegate> delegate;
@property (nonatomic, retain) tvseries *series;
@property (nonatomic, retain) NSMutableArray *shows;
@property (nonatomic, retain) NSMutableString *currentElementValue;

@end
