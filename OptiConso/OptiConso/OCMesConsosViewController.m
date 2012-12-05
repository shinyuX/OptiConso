//
//  OCMesConsosViewController.m
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OCMesConsosViewController.h"

@implementation OCMesConsosViewController

@synthesize graphView;
@synthesize connected;

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-color.jpeg"]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    self.connected = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.connected)
        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
    else
    {
        NSURL *url = [NSURL URLWithString:@"http://opticonso.fr/api/v1/graph/graph?auth_token=zMxD5d4AzegcWuKLfxYD"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.graphView loadRequest:request];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"LoginSegue"])
    {
        OCLoginViewController *login = segue.destinationViewController; 
        login.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ModifierSegue"])
    {
        OCModifierViewController *modifier = segue.destinationViewController; 
        modifier.delegate = self;
    }
}

#pragma mark - LoginViewController Delegate

- (void)LoginViewDidValidateAuthentication
{
    [self dismissModalViewControllerAnimated:YES];
    self.connected = YES;
}

#pragma mark - ModifierViewController Delegate

- (void)ModifierViewDidAddValue:(NSInteger)value forEnergy:(NSInteger)energy date:(NSString *)date
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
