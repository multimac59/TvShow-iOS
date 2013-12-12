//
//  GetLiveFeedDelegate.h
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetLiveFeedDelegate <NSObject>

- (void)serviceFinished:(id)service withError:(BOOL)error;
@end
