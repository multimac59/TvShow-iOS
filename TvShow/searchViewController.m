//
//  searchViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "searchViewController.h"
#import "tvseries.h"
#import "GetSeries.h"
#import "PKRevealController.h"
@interface searchViewController ()

@end

@implementation searchViewController

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

    // Setup search bar
    self.filmSearch.delegate = self;
    
    // Setting up a menu button to launch the left menu
   // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleTray:)];
    
    UIImage * menuBtn = [UIImage imageNamed:@"trayicon"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuBtn style:UIBarButtonItemStylePlain target:self action:@selector(toggleTray:)];
    
}

- (void)toggleTray:(id)sender
{
     [[self.navigationController revealController] showViewController:[self.navigationController revealController].leftViewController animated:YES completion:nil];
    
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
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Linking cells with identifier specified for prototpye cells
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seriesCell"];
    // Create an instance of tvseries from the array which has the objects created earlier
    tvseries *exampleSeries = (self.searchResults)[indexPath.row];
    
    // Set the values.
    cell.textLabel.text = exampleSeries.name;
    cell.detailTextLabel.text = exampleSeries.firstAired;
    return cell;
}

// When a cell is clicked
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%@", indexPath);
    self.atIndex = indexPath.row;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
    // Set search term.
    NSString *searchTerm = [searchBar text];
    
    //Create and init service with search term.
    GetSeries *service = [[GetSeries alloc] init];
    service.searchTerm = searchTerm;
    [service setDelegate:self];
    
    [self.searchResults removeAllObjects];
    
    [service main];
    [[self tableView] reloadData];
    
    // Show a progress indicator while searching
    // create and set the indicator
    progress = [[UIActivityIndicatorView alloc ]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:progress];
    // Set the size
    progress.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 8) - 5);
    // Start the indicator
    [progress startAnimating];
    
    // Get rid of keyboard
    [searchBar resignFirstResponder];
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchResults removeAllObjects];
    [[self tableView] reloadData];
}

- (void) serviceFinished:(id)service withError:(BOOL)error  {

    
    if (!error) {
        [searchResults removeAllObjects];
        self.searchResults = [service shows];
        
        // If no results found
        if ([searchResults count] == 0){
            NSLog(@"no results");
            // Create alert
            UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Problem!" message:@"No Search Results Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            // Stop Spinner
            // Show alert
            [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
            [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
        }
        
        else {
            // Reload tableview
            // Stop spinner
            [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
            [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];
        }
        
    }
    else {
        NSLog(@"Error");
        // IF erro, create alert
        UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error with your search" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        //Show the alert
        //Stop the spinner
        [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
        [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
    }
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected tvseries object to the new controller
    ((detailedShowViewController*)segue.destinationViewController).series = searchResults[[self.tableView indexPathForCell:(UITableViewCell*)sender].row];
}


@end
