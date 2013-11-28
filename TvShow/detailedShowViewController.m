//
//  detailedShowViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "detailedShowViewController.h"

@interface detailedShowViewController ()

@end

@implementation detailedShowViewController

@synthesize series;
@synthesize overview;
@synthesize banner;
@synthesize navBar;
@synthesize airDate;
@synthesize network;
@synthesize imdb;
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
	// Do any additional setup after loading the view.
    NSLog(@"%@",series.overview);
    //detailedShowViewController.la
    overview.text = series.overview;
    airDate.text = [NSString stringWithFormat:@"Air Date: %@",series.firstAired];
    network.text = [NSString stringWithFormat:@"Network: %@",series.network];
    navBar.title = series.name;
    
    if ([series.imdb length] > 3) {
        
        [imdb setTitle:@"IMDB Page" forState:UIControlStateNormal];
        [imdb addTarget:self action:@selector(LaunchURL) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    else {
        [imdb setTitle:@"" forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc]initWithFrame:imdb.frame];
        label.text = @"No IMDB Page Found";
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        [self.view addSubview:label];
    }

    if ([series.banner length] > 9) {
        NSLog(@"banner exists");
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(backgroundQueue, ^{
            
            // Create the URL request
         
            NSString *url = [NSString stringWithFormat:@"http://thetvdb.com/banners/%@", series.banner];
            NSLog(@"URL: %@", url);
            NSError *error = nil;
            NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                                        cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
            // Create a data object to store the recieved data.
            NSData *image = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error];
            
            if (!error && image && [image length] > 0){
                NSLog(@"no errors with data");
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
               
                NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
                
                [image writeToFile:filePath options:0 error:&error];
            
            //UIImage *temp = [[UIImage alloc] initWithData:image];
                UIImage *temp = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
                [banner performSelectorOnMainThread:@selector(setImage:) withObject:temp waitUntilDone:NO];
            }
        });
        
    }
    
    
}

- (void) LaunchURL
{
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://imdb.com/title/%@",series.imdb]];
    [[UIApplication sharedApplication]openURL:url];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
