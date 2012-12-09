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
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *token = [defaults objectForKey:@"kToken"];
        NSString *urlString = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/graph/graph?auth_token=%@&type=%@", token, @"eau"];
        NSURL *url = [NSURL URLWithString:urlString];
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

- (IBAction)energyButton:(id)sender
{
    UIActionSheet *energy = [[UIActionSheet alloc] initWithTitle:@"Choisir une energie" delegate:self cancelButtonTitle:@"Annuler" destructiveButtonTitle:nil otherButtonTitles:@"Eau", @"Electricte", @"Gaz", nil];
    energy.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [energy showFromTabBar:self.tabBarController.tabBar];
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
    else if ([segue.identifier isEqualToString:@"ChangerSegue"])
    {
        OCChangerHabitatViewController *changer = segue.destinationViewController; 
        changer.delegate = self;
    }
}

#pragma mark - LoginViewController Delegate

- (void)LoginViewDidValidateAuthentication
{
    [self dismissModalViewControllerAnimated:YES];
    self.connected = YES;
}

#pragma mark - ModifierViewController Delegate

- (void)ModifierViewDidAddValue
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.graphView reload];
}

#pragma mark - ChangerViewController Delegate

- (void)ChangerViewDidPickHabitat:(OCHabitat *)habitat
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.graphView reload];
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *newEnergy = @"";
    switch (buttonIndex) {
        case 0:
            newEnergy = @"eau";
            break;
        case 1:
            newEnergy = @"elec";
            break;
        case 2:
            newEnergy = @"gaz";
            break;
            
        default:
            return;
            break;
    }
 
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"kToken"];
    NSString *urlString = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/graph/graph?auth_token=%@&type=%@", token, newEnergy];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.graphView loadRequest:request];
}

@end
