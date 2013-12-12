//
//  detailedEpisodeViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "detailedEpisodeViewController.h"

@interface detailedEpisodeViewController ()

@end

@implementation detailedEpisodeViewController

//Set up properties
@synthesize targetEpisode; //This is set via prepareForSegue

@synthesize seasonLbl;
@synthesize episodeLbl;
@synthesize airDateLbl;
@synthesize ratingLbl;
@synthesize overviewTxt;
@synthesize banner;
@synthesize season;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
   
    //Setting Title
    self.title = targetEpisode.episodeName;
    
    // Setting all other variables
    seasonLbl.text = season;
    episodeLbl.text = [NSString stringWithFormat:@"Episode: %d",targetEpisode.episodeNumber];
    
    if ([targetEpisode.airDate length] > 2) {
        NSString *date = [targetEpisode.airDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        airDateLbl.text = [NSString stringWithFormat:@"Air Date: %@",date];
    }else {
        
        airDateLbl.text = [NSString stringWithFormat:@"Air Date: Not Found"];
        [airDateLbl setTextColor:[UIColor grayColor]];
    }
    if ([targetEpisode.overview length] > 10) {
        overviewTxt.text = targetEpisode.overview;
    }else {
        overviewTxt.text = [NSString stringWithFormat:@"No Overview Found"];
        [overviewTxt setTextColor:[UIColor grayColor]];
    }
    if ([targetEpisode.rating length] > 1) {
        NSString *rating = [targetEpisode.rating stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        ratingLbl.text = [NSString stringWithFormat:@"Rating: %@",rating];
    }else {
        ratingLbl.text = [NSString stringWithFormat:@"Rating: Not Found"];
        [ratingLbl setTextColor:[UIColor grayColor]];
    }
    
    // Fetching the image
    // Setting a banner image
    // check that a suitable url is present
    if ([targetEpisode.imageUrl length] > 9) {
        // Use a grand central dispatch thread
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(backgroundQueue, ^{
            
            // Create the URL request
            NSString *imageUrlFixed = [targetEpisode.imageUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *url = [NSString stringWithFormat:@"http://thetvdb.com/banners/%@", imageUrlFixed];
            NSLog(@"URL: %@", url);
            NSError *error = nil;
            NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                        cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
            
            // Create a data object to store the recieved data.
            NSData *image = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error];
            
            if (!error && image && [image length] > 0){
                NSLog(@"no errors with data");
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                
                // Store to file
                NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
                
                [image writeToFile:filePath options:0 error:&error];
                
                // Create the image
                UIImage *temp = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
                // Set up a transition
                CATransition *animation = [CATransition animation];
                [animation setDuration:2.0];
                [animation setType:kCATransitionFromTop];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
                
                // View the image and perform the animation on the main thread
                [[banner layer ]performSelectorOnMainThread:@selector(addAnimation:forKey:) withObject:animation waitUntilDone:NO];
                [banner performSelectorOnMainThread:@selector(setImage:) withObject:temp waitUntilDone:NO];
                
                filePath = nil;
            }
        });
    }
    else // If no banner url is found
    {
        // Set default image
        NSLog(@"No Default Picture");
        UIImage *temp = [UIImage imageNamed:@"defaultBanner"];
        // With the same animation
        CATransition *animation = [CATransition animation];
        [animation setDuration:2.0];
        [animation setType:kCATransitionFromTop];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [[banner layer ]performSelectorOnMainThread:@selector(addAnimation:forKey:) withObject:animation waitUntilDone:NO];
        [banner performSelectorOnMainThread:@selector(setImage:) withObject:temp waitUntilDone:NO];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
