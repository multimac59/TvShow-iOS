//
//  ServiceDelegate.h
//  TvShow
//
//  Created by Shazib Hussain on 26/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceDelegate <NSObject>

- (void) serviceFinished:(id)service WithError:(BOOL)error;

@end
