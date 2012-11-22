//
//  OCLoginViewController.m
//  OptiConso
//
//  Created by Epi Mac on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OCLoginViewController.h"

@implementation OCLoginViewController

@synthesize ACS;
@synthesize usernameText;
@synthesize passText;
@synthesize delegate;

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ACS = [[OCAuthenticationService alloc] initWithDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-color.jpeg"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.usernameText isFirstResponder])
        [self.usernameText resignFirstResponder];
    if ([self.passText isFirstResponder])
        [self.passText resignFirstResponder];
}

- (IBAction)validateButton:(id)sender
{
    [self.ACS launchConnectionForUsername:[self.usernameText text] pass:[self.passText text]];
}

#pragma mark - OCAuthenticationService Delegate

- (void)ACSDidFinishParsing:(NSString *)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"kToken"];
    [self.delegate LoginViewDidValidateAuthentication];
}

- (void)ACSDidEndWithError
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"L'authentification a echoue. Veuillez verifier votre connexion internet et reessayer ulterieurement.", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        default:
            break;
    }
}

@end
