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

    NSLog(@"LOADEDLOADEDLOADED");
    
    // Setup search bar
    self.filmSearch.delegate = self;
    
  
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
    cell.detailTextLabel.text = exampleSeries.seriesId;
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
   
    // Debug Logging.
    NSLog(@"search button pressed");
    // Set search term.
    NSString *searchTerm = [searchBar text];
    
    //Create and init service with search term.
    GetSeries *service = [[GetSeries alloc] init];
    NSLog(@"create service");
    service.searchTerm = searchTerm;
    NSLog(@"set search term");
    [service setDelegate:self];
    NSLog(@"set delegate");
    
    [self.searchResults removeAllObjects];
    NSLog(@"objects removed");
    
    [service main];
    NSLog(@"main method executed");
    [[self tableView] reloadData];
    NSLog(@"tableview reloaded in searchbuttonclicked");
    
    progress = [[UIActivityIndicatorView alloc ]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:progress];
    progress.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 8) - 5);
    [progress startAnimating];
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
            UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Problem!" message:@"No Search Results Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];
        } else {
            // Reload tableview
            [progress performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
            [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];
            NSLog(@"tablewview reloaded in servicefinishedwitherror");
        }
        
    }
    else {
        NSLog(@"Error");
        UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error with your search" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        //[noResults show];
        [noResults performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:NO];

    }
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ((detailedShowViewController*)segue.destinationViewController).index = [self.tableView indexPathForCell:(UITableViewCell*)sender].row;
    ((detailedShowViewController*)segue.destinationViewController).series = searchResults[[self.tableView indexPathForCell:(UITableViewCell*)sender].row];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

//MenuViewController *menu = [navController.storyboard instantiateViewControllerWithIdentifier:@"MenuController"];


@end
