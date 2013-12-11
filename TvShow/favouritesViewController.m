//
//  favouritesViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "favouritesViewController.h"
#import "detailedShowViewController.h"
#import "tvshowAppDelegate.h"
#import "SeriesEntity.h"
#import "tvseries.h"

@interface favouritesViewController ()

@end

@implementation favouritesViewController


@synthesize valuesForTable;


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Create an array from thhe core data model
    // Importing the data model
    tvshowAppDelegate *appDelegate = (tvshowAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];

    // First we Check that the series does not already exist
    // Create a fetch request, think of this like a SQL SELECT statement.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SeriesEntity" inManagedObjectContext:self.managedObjectContext];
    //Set the table to perform the request on
    [request setEntity:entity];
    // Set descriptor for ordering the fetched results
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"seriesID" ascending:NO];
    // Execute the request
    [request setSortDescriptors:@[sortDescriptor]];

    // Create an array with the the returned values.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // If there is an error, show an alert
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error setting this favourite" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        valuesForTable = mutableFetchResults;
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
    return [self.valuesForTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favouriteCell" ];
    
    // Configure the cell...
    SeriesEntity *exampleSeries = (self.valuesForTable)[indexPath.row];
    tvseries * series = exampleSeries.series;
    // Set the values.
    cell.textLabel.text = series.name;
    cell.detailTextLabel.text = series.seriesId;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.atIndex = indexPath.row;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        // Delete the row from the data source
        
        
        // Delete the object from the persistant dat store
        NSManagedObject *temp = valuesForTable[indexPath.row];
        NSError * error;
        [self.managedObjectContext deleteObject:temp];
        [self.managedObjectContext save:&error];
        if (error) {
            NSLog(@"error deleting values");
        }
        // Delete from array
        [valuesForTable removeObjectAtIndex:indexPath.row];
        NSLog(@"Removed value from array");
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SeriesEntity *seriesEntity = valuesForTable[[self.tableView indexPathForCell:(UITableViewCell*)sender].row];
    tvseries *series = seriesEntity.series;

    ((detailedShowViewController*)segue.destinationViewController).series = series;
    
}



@end
