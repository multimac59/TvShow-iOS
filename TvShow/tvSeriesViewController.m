//
//  tvSeriesViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//
/*
#import "tvSeriesViewController.h"
#import "tvseries.h"

@interface tvSeriesViewController ()

@end

@implementation tvSeriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSLog(@"LOADED INIT");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"LOADEDLOADEDLOADED");
   
    // Custom Logic
    // Create array
    _series = [NSMutableArray arrayWithCapacity:20];
    
    // Create some tvseries objects for displaying
    
    // Create new object and assign values
    tvseries *exampleseries = [[tvseries alloc] init];
    exampleseries.name = @"Buffy The Vampire Slayer";
    exampleseries.seriesId = @"12345";
    exampleseries.network = @"HBO";
    exampleseries.banner = @"/poster/img6669.jpg";
    exampleseries.overview = @"The exciting blah blah of Buffy the Vampire Slayer";
    exampleseries.firstAired = @"12/12/12";
    exampleseries.genre = @"Horror|Fantasy";
    // Add object to array
    [_series addObject:exampleseries];
    
    // Resassign values
    exampleseries = [[tvseries alloc] init];
    exampleseries.name = @"Breaking Bad";
    exampleseries.seriesId = @"12345";
    exampleseries.network = @"HBO";
    exampleseries.banner = @"/poster/img6669.jpg";
    exampleseries.overview = @"The exciting blah blah of Buffy the Vampire Slayer";
    exampleseries.firstAired = @"12/12/12";
    exampleseries.genre = @"Horror|Fantasy";
    // Add object to array
    [_series addObject:exampleseries];
    
    // Resassign Values
    exampleseries = [[tvseries alloc] init];
    exampleseries.name = @"The Walking Dead";
    exampleseries.seriesId = @"12345";
    exampleseries.network = @"HBO";
    exampleseries.banner = @"/poster/img6669.jpg";
    exampleseries.overview = @"The exciting blah blah of Buffy the Vampire Slayer";
    exampleseries.firstAired = @"12/12/12";
    exampleseries.genre = @"Horror|Fantasy";
    // Add object to array
    [_series addObject:exampleseries];
    
    self.series = _series;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of objects in the array
    return [self.series count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Linking cells with identifier specified for prototpye cells
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seriesCell"];
    // Create an instance of tvseries from the array which has the objects created earlier
    tvseries *exampleSeries = (self.series)[indexPath.row];
    
    // Set the values.
    cell.textLabel.text = exampleSeries.name;
    cell.detailTextLabel.text = exampleSeries.seriesId;
    
    return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 

@end
*/
