//
//  GetSeriesDelegate.h
//  TvShow
//
//  Created by Shazib Hussain on 27/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetSeriesDelegate <NSObject>

- (void)serviceFinished:(id)service withError:(BOOL)error;


@end

