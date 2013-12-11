//
//  tvseriesToDataTransformer.m
//  TvShow
//
//  Created by Shazib Hussain on 29/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "tvseriesToDataTransformer.h"

@implementation tvseriesToDataTransformer


+ (BOOL)allowsReverseTransformation {
    return YES;
}

+(Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

- (id)reverseTransformedValue:(id)value {
    
    return [NSKeyedUnarchiver  unarchiveObjectWithData:value];
}

@end
