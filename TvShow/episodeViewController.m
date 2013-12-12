//
//  episodeViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "episodeViewController.h"
#import "episode.h"

@interface episodeViewController ()

@end

@implementation episodeViewController

@synthesize episodes;
@synthesize cellTitle;

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

    // Set the title
    self.title = cellTitle;
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
    return [episodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"episodeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    //NSLog(@"valueforindex: %d", indexPath.row);
    
    episode * temp = episodes[indexPath.row];
    NSString *rating = [temp.rating stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.textLabel.text = [NSString stringWithFormat:@"Episode %d",temp.episodeNumber];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Rating: %@",rating];
    
    NSLog(@"rating:%@",temp.rating);
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
