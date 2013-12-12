//
//  Entity.h
//  TvShow
//
//  Created by Shazib Hussain on 29/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TvShow/tvseries.h"

// This is the auto generated entity created from the data model
// Note the custom data type

@interface SeriesEntity : NSManagedObject

@property (nonatomic) tvseries * series;
@property (nonatomic) NSString * seriesID;

@end
