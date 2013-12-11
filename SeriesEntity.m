//
//  Entity.m
//  TvShow
//
//  Created by Shazib Hussain on 29/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "SeriesEntity.h"

#import "tvseriesToDataTransformer.h"

@implementation SeriesEntity

@dynamic series;
@dynamic seriesID;



+ (void)initialize {
    if (self == [SeriesEntity class]){
        tvseriesToDataTransformer *tranformer = [[tvseriesToDataTransformer alloc] init];
        [NSValueTransformer setValueTransformer:tranformer forName:@"tvseriesToDataTransformer"];
    }
}

@end
