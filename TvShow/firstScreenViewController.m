//
//  firstScreenViewController.m
//  TvShow
//
//  Created by Shazib Hussain on 12/12/2013.
//  Copyright (c) 2013 com.shazib. All rights reserved.
//

#import "firstScreenViewController.h"
#import "PKRevealController.h"
#import <QuartzCore/QuartzCore.h>
@interface firstScreenViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *centreImageView;

@end

@implementation firstScreenViewController

@synthesize centreImageView;


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
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 3.0; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [centreImageView.layer addAnimation:rotation forKey:@"Spin"];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// When Button is Clicked
- (IBAction)onClick:(UIButton *)sender {
    NSLog(@"BUTTON CLICKED");
         [[self revealController] showViewController:[self revealController].leftViewController animated:YES completion:nil];
}
     

@end
