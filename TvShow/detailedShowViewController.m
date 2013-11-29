//
//  detailedShowViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "detailedShowViewController.h"
#import "tvshowAppDelegate.h"

@interface detailedShowViewController ()

@end

@implementation detailedShowViewController

// Synthesise the IBOutlets and the series objct which is carried over from the search.
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
    // NSLog(@"%@",series.overview);
    
    // Setting the Labels using the carried over tvseries object.
    overview.text = series.overview;
    airDate.text = [NSString stringWithFormat:@"Air Date: %@",series.firstAired];
    network.text = [NSString stringWithFormat:@"Network: %@",series.network];
    navBar.title = series.name;
    
    // Create an array of buttons for the navbar, the share and add buttons.
    // The interface builder only allows you to add one button, so this has to be done in code.
    // Creating buttons:
    UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClick)];
    // Adding buttons to the navigation bar:
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnAdd, btnShare, nil]];
     
    
    // Simple check to see if there is a valid IMDB ID found in the object
    if ([series.imdb length] > 3) {
        // Set the button title, and action to run the method, LaunchURL
        [imdb setTitle:@"IMDB Page" forState:UIControlStateNormal];
        [imdb addTarget:self action:@selector(LaunchURL) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        // If there is no valid ID, set the button text to blank
        [imdb setTitle:@"" forState:UIControlStateNormal];
        // Create a label inside the button
        UILabel *label = [[UILabel alloc]initWithFrame:imdb.frame];
        // Set the text, colour etc.
        label.text = @"No IMDB Page Found";
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        // Add the label to the view
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
    // Create a url for the imdb page using the imdb id value from the tvseries object
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://imdb.com/title/%@",series.imdb]];
    // Use sharedApplication to launch safari.
    [[UIApplication sharedApplication]openURL:url];
    
}

- (void) addBtnClick
{
    // Add the current series object to the data store.
    
    [(tvshowAppDelegate *)[[UIApplication sharedApplication] delegate]
     seriesDoesExist:series.seriesId];
    
    
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seriesCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seriesCell"];
    }
    

    
    cell.textLabel.text = @"hello";
    return cell;
}

// When a cell is clicked
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
