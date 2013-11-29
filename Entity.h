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


@interface Entity : NSManagedObject

@property (nonatomic, retain) tvseries * series;

@end
