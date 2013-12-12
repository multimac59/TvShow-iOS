//
//  detailedShowViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 22/11/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

// This controller views the data of a particular show, which is selected in the search, or from the favourites.
// A series object is passed from the search/favourite controllers
// The GetEpisode class uses the seriesID of the series object to create an array of all episodes
// The array is passed in its entirity to the controller
// This array is then separated into seasons and presented in a tableview
// The controller also displays various other data contained within the series object
// The controller internally handles viewing a banner image, using a url from the series object
// Core data functionallity to save objects is implmented and called via an 'add' button
// To 'add' button disappears if the program is already in the core data persistant data store.
// The series object itself is saved


#import "detailedShowViewController.h"

@interface detailedShowViewController ()

@end

@implementation detailedShowViewController

// Synthesise the properties
@synthesize series;
@synthesize overview;
@synthesize banner;
@synthesize navBar;
@synthesize airDate;
@synthesize network;
@synthesize imdb;
@synthesize episodes;
@synthesize table;
@synthesize numberOfSeasons;
@synthesize seasonsDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

        
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    // Before the view appear, create an instance of GetEpisode
    // Empty the array (not really needed)
    // Run the main service
    // Reload the tableview (also not really needed)
    
    GetEpisodes * service = [[GetEpisodes alloc] init];
    service.seriesID = self.series.seriesId;
    [service setDelegate:self];
    [self.episodes removeAllObjects];
    [service main];
    [self.table reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Importing the data model
    tvshowAppDelegate *appDelegate = (tvshowAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.managedObjectContext = [appDelegate managedObjectContext];
    
    // Setting up PKRevealController
    [self.navigationController.navigationBar addGestureRecognizer:self.revealController.revealPanGestureRecognizer];
    
    // Setting title
    navBar.title = series.name;
    
    //Setting Default Values for labels and buttons
    // These checks just check for a rough length as if can be assumed that the text should not be shorter than this
    // If there is no overview
        if ([series.overview length] < 5) {
            // Set a default value
            overview.text = @"No Overview Found";
        }
        else // Otherwise
        {
            // Set the text using the value from the series object
            overview.text = series.overview;
            
        }
    // If there is no network value
        if ([series.network length] < 2) {
            // Set a default string
            network.text = @"No Network Found";
        }
        else // Otherwise set the value
        {
            network.text = [NSString stringWithFormat:@"Network: %@",series.network];
        }
    // If there is no air data
        if ([series.firstAired length] < 9) {
            // Set a default
            airDate.text = @"No Air Date Found";
        }
        else
        {
            // Set the air date.
            airDate.text = [NSString stringWithFormat:@"Air Date: %@",series.firstAired];
        }
    // Simple check to see if there is a valid IMDB ID found in the series object
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
    
    
    // A Check is carried out to see if the series already exists in the data store.
    // Create a fetch request, think of this like a SQL SELECT statement.
    // This is so that the 'add' button can be hidden
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
    
    // If there is an error fetching the results
	if (mutableFetchResults == nil) {
        // Allow the button to be shown, the check is also handled again.
        // Adding buttons to the navigation bar:
        // Create an array of buttons for the navbar, the share and add buttons.
        // The interface builder only allows you to add one button, so this has to be done in code.
        // Creating buttons:
        NSLog(@"results are nil, add both");
        UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
        UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClick)];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnAdd, btnShare, nil]];
        return;
	}
    BOOL found = FALSE;
    
    if (mutableFetchResults != nil){
        // If the data is successfully retrieved, check that the series has not already been added.
        // For each 'record' of type SeriesEntity [the table] in the array
       
        for (SeriesEntity * bob in mutableFetchResults){
            // If the seriesid of the current show is equal to the value in the array
            if ([bob.seriesID isEqualToString:self.series.seriesId]) {
                // If the show has been added, show only the share button
                // Adding buttons to the navigation bar:
                // Create an array of buttons for the navbar, the share and add buttons.
                // The interface builder only allows you to add one button, so this has to be done in code.
                // Creating buttons:
               found = TRUE;
                UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
                [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnShare, nil]];
            }
        }
        // Otherwise, add both buttons.
        // Adding buttons to the navigation bar:
        // Create an array of buttons for the navbar, the share and add buttons.
        // The interface builder only allows you to add one button, so this has to be done in code.
        // Creating buttons:
        if (!found) {
            NSLog(@"none found, add both");
            UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
            UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClick)];
            [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:btnAdd, btnShare, nil]];
        }
    }
    
    
    
    // Setting a banner image
    // check that a suitable url is present
    if ([series.banner length] > 9) {
        // Use a grand central dispatch thread
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

- (void) LaunchURL
{
    // Create a url for the imdb page using the imdb id value from the tvseries object
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://imdb.com/title/%@",series.imdb]];
    // Use sharedApplication to launch safari.
    [[UIApplication sharedApplication]openURL:url];
    
}

// This method adds the selected Tvseries to the entity 'SeriesEntity' which stores all favourited shows.

- (void) addBtnClick
{
   
    // First we Check that the value does not already exist
    
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
		// If there is an error, show an alert.
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error checking if this favourite exists" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        // Show the alert and return the method
        [alert show];
        return;
	}
    // If the data is successfully retrieved, check that the series has not already been added.
    // For each 'record' of type SeriesEntity [the table] in the array
    for (SeriesEntity * bob in mutableFetchResults){
        // If the seriesid of the current show is equal to the value in the array
        if ([bob.seriesID isEqualToString:self.series.seriesId]) {
            // Show an alert and return, do not add the value.
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You have already favourited this show" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    
    // If the method has not returned at this stage,
    // Then the show may be saved.
    
    // Create a instance of the entity type
    SeriesEntity *event = (SeriesEntity *)[NSEntityDescription insertNewObjectForEntityForName:@"SeriesEntity" inManagedObjectContext:self.managedObjectContext];
    // Set the values using the current object
    [event setSeries:series];
    [event setSeriesID:self.series.seriesId];
	
    // Save to the managedObjectContext
	if (![self.managedObjectContext save:&error]) {
        
        // Error handling
        // Return an alert, log the error
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"There was an error setting this favourite" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        // Show the alert and return the method
        [alert show];
	}
    else {
        //Return a success message
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Yay!" message:@"The Show Was Favourited" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        // Show the alert and return the method
        [alert show];
        //reload display to no longer show the add button
        
        [self viewDidLoad];
    
    }
    return;
    
}

- (void) share {
    // This method simply create a url for sharing the tvseries
    // And calls shareText
    NSString *urlBase = @"http://thetvdb.com/?tab=series&id=%@";
    NSString *urlFull = [urlBase stringByAppendingString:self.series.seriesId];
    [self shareText:urlFull];
}

// This method launches the share sheet by adding the url to an array of posible items and presenting the controller
- (void)shareText:(NSString *)string {
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (string) {
        [sharingItems addObject:string];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}



/////////////////////////////TABLEVIEW METHODS////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfSeasons;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seasonCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seasonCell"];
    }
    

    
    cell.textLabel.text = [NSString stringWithFormat:@"Season %d", (indexPath.row+1)];
    return cell;
}

// When a cell is clicked
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


// This method is used to pass a specific set of episodes for a specific season to the episode view controller.

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
   
   
    NSString *temp = [NSString stringWithFormat:@"season%d",[table indexPathForCell:(UITableViewCell*)sender].row+1];
    
    NSMutableArray *seasonToSend = [[NSMutableArray alloc]init];
    
    seasonToSend = [self.seasonsDict valueForKey:temp];
    
    ((episodeViewController*)segue.destinationViewController).episodes = seasonToSend;
    ((episodeViewController*)segue.destinationViewController).cellTitle = [NSString stringWithFormat:@"Season: %d", ([table indexPathForCell:(UITableViewCell*)sender].row+1)];
}


// This method is called from GetEpisode and performs the separation of episodes into seasons

- (void) serviceFinished:(id)service withError:(BOOL)error  {
    
    NSLog(@"service finished with error is called");
    
    // If No Error
    if (!error) {
        // Now the episodes collected by GetEpisodes must be separated into seasons.
        // First assign the episodes to a global array
        self.episodes = [service episodes];
        
        // Now we must calculate how many seasons there are. this differs for different shows; sometimes the first episode is the first
        // Sometimes the first episode is the last
        // A simple if statment determines which has the highest season number.
        
        episode * tempEpLast = self.episodes[([self.episodes count] - 1)];
        episode * tempEpFirst = self.episodes[0];
        episode * final = [[episode alloc] init];
        
        if (tempEpFirst.seasonNumber > tempEpLast.seasonNumber) {
            final = tempEpFirst;
            
        }else {
            final = tempEpLast;
        }
        // The 'final' episode will have the last possible season number
        
        //number of total seasons
        self.numberOfSeasons = final.seasonNumber;
        self.seasonsDict = [[NSMutableDictionary alloc] initWithCapacity:numberOfSeasons];
        
        NSLog(@"number of seasons: %d", self.numberOfSeasons);
        
        for (int a = 1; a <= numberOfSeasons; a++) {
            //NSLog(@"A BEFORE:%d",a);
            // An array is added to a NSMutableDictionary for each season
            NSString *temp = [NSString stringWithFormat:@"season%d",a];
            [self.seasonsDict setObject:[[NSMutableArray alloc] init] forKey:temp];
            //NSLog(@"adding array object to dictionary.");
        }
        // Now to separate the episodes into seasons
        // For each episode in the array of episodes, add to a specific array in the dictionary
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        //int counter = numberOfSeasons;
        
        for (int i = 0; i < [self.episodes count]; i++) {
            
            episode *temp = self.episodes[i];
            int seasonNum = temp.seasonNumber;
            //NSLog(@"overview for ep:%@", temp.overview);
            NSString *temporary = [NSString stringWithFormat:@"season%d",seasonNum];
            //NSLog(@"adding object temp to dict");
            [tempArray addObject:temp];
            [self.seasonsDict setObject:tempArray forKey:temporary];
            
            if ((i+1) < [self.episodes count]) {
                
                episode *checker = self.episodes[i+1];
                if (checker.seasonNumber !=seasonNum){
                    [tempArray removeAllObjects];
                }
            }
            
        }
        
        // Checking that the pass was successful
        //NSMutableArray *temp = [self.seasonsDict valueForKey:@"season1"];
        //tempEpFirst = temp[0];
        //NSLog(@"value for overview is passed:%@", tempEpFirst.overview);
        
        // Reload Tableview
        
        [table performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
