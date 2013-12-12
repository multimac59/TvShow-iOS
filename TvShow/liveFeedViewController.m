//
//  liveFeedViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//


#import "liveFeedViewController.h"
#import "PKRevealController.h"
#import "episode.h"
#import "GetLiveFeedDelegate.h"
#import "GetLiveFeed.h"


@interface liveFeedViewController ()

@end

@implementation liveFeedViewController

@synthesize searchResults;
@synthesize progress;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * menuBtn = [UIImage imageNamed:@"trayicon"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuBtn style:UIBarButtonItemStylePlain target:self action:@selector(toggleTray:)];
  
    GetLiveFeed *service =[[GetLiveFeed alloc]init];
    [service setDelegate:self];
    [service main];
    [[self tableView] reloadData];
    
}

- (void)toggleTray:(id)sender
{
    [[self.navigationController revealController] showViewController:[self.navigationController revealController].leftViewController animated:YES completion:nil];
    
}

- (void) serviceFinished:(id)service withError:(BOOL)error  {
    
    
    if (!error) {
        [searchResults removeAllObjects];
        
        self.searchResults = [service episodes];
        
        // If no results found
        if ([searchResults count] == 0){
            NSLog(@"no results");
            UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Problem!" message:@"No Search Results Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
            [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];        } else {
                // Reload tableview
                [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
                [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                                 withObject:nil
                                              waitUntilDone:NO];
            }
        
    }
    else {
        NSLog(@"Error");
        UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error with your search" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //[noResults show];
        [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
        [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liveFeedCell"];
    episode *temp = (self.searchResults)[indexPath.row];
    // Configure the cell...
    
    cell.textLabel.text = temp.episodeName;
    NSString *date = [temp.airDate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailTextLabel.text = date;
    return cell;
}



@end
