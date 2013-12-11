//
//  GetEpisodesDelegate.h
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetEpisodesDelegate <NSObject>

- (void)serviceFinished:(id)service withError:(BOOL)error;

@end
