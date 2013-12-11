//
//  tvshowStartViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 11/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "tvshowStartViewController.h"
#import "PKRevealController.h"
#import "searchViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)whenClicked:(UIButton *)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    searchViewController *searchController = (searchViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"searchController"];
    
    self.revealController.frontViewController = searchController;
     
    
    
}

@end
