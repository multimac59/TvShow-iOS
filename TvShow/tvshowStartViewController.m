//
//  tvshowStartViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "tvshowStartViewController.h"

// Importing the required RevealController
#import "PKRevealController.h"


@interface tvshowStartViewController ()

@end

@implementation tvshowStartViewController

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
	
    // The reveal width is set for the left menu.
    [self.revealController setMinimumWidth:130 maximumWidth:190 forViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)whenSearchClicked:(UIButton *)sender {
    
    // When the button is clicked, the front view is changed to the search menu
    // The storyboard is only used to reference the navigation view via the storyboard identifier
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *navController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"initalNav"];
    
    self.revealController.frontViewController = navController;
    
}

- (IBAction)whenFavouritesClicked:(UIButton *)sender {
    
    // When the button is clicked, the front view is changed to the favourites menu
    // The storyboard is only used to reference the navigation view via the storyboard identifier
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *navController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"favouritesNav"];
    
    self.revealController.frontViewController = navController;
}

- (IBAction)whenLiveFeedClicked:(UIButton *)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *navController = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"liveFeedController"];
    
    self.revealController.frontViewController = navController;}

@end
