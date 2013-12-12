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
#import "welcomeView.h"
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

- (void)viewWillAppear:(BOOL)animated {
    
    
    // The welcome view notification was made by a third party.
    // I have jsut copied the code in so the app is easier to use.
    welcomeView *welcomeAnnotation = [[welcomeView alloc]initWithFrame:CGRectZero];
    
    [welcomeAnnotation setFrame:CGRectMake(2, 45, 300, 120)];
    [welcomeAnnotation setAlpha:0];
    
    // Slide the welcome annotation up and fade it in
    [UIView animateWithDuration:0.2 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [welcomeAnnotation setAlpha:1];
        [welcomeAnnotation setFrame:UIEdgeInsetsInsetRect(welcomeAnnotation.frame, UIEdgeInsetsMake(-10, 0, 10, 0))];
    } completion:nil];
    
    [self.view addSubview:welcomeAnnotation];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    // Set up an animation to rotate the picture
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 3.0; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever.
    [centreImageView.layer addAnimation:rotation forKey:@"Spin"];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// When Button is Clicked
- (IBAction)onClick:(UIButton *)sender {
        // reveal side controller.
         [[self revealController] showViewController:[self revealController].leftViewController animated:YES completion:nil];
}
     

@end
