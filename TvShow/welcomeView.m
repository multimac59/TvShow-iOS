//
//  welcomeView.m
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "welcomeView.h"

@implementation welcomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    //// Abstracted Attributes
    NSString* instructionsContent = @"Tap this button or swipe right to get started.";
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 21, 200, 45) cornerRadius:4];
    [[UIColor colorWithWhite:0 alpha:0.7f] setFill];
    [roundedRectanglePath fill];
    
    //// Bezier Drawing
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 21)];
    [bezierPath addLineToPoint:CGPointMake(22, 12)];
    [bezierPath addLineToPoint:CGPointMake(34, 21)];
    [bezierPath closePath];
    [[UIColor colorWithWhite:0 alpha:0.7f] setFill];
    [bezierPath fill];
    
    //// Instructions Drawing
    CGRect text2Rect = CGRectMake(5, 25, 190, 45);
    [[UIColor whiteColor] setFill];
    [instructionsContent drawInRect:text2Rect
                           withFont:[UIFont fontWithName:@"AnticSlab-Regular" size:14]
                      lineBreakMode:NSLineBreakByWordWrapping
                          alignment:NSTextAlignmentCenter];}


@end
