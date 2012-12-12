//
//  OCComparerWithViewController.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCComparerWithViewController.h"

@implementation OCComparerWithViewController
@synthesize graphView;
@synthesize compare;

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

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"kToken"];
    NSString *urlString = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/graphComp/graph?idhab=%d&auth_token=%@&type=%@", self.compare.habitatId, token, @"eau"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.graphView loadRequest:request];

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
    NSString *urlString = [NSString stringWithFormat:@"http://opticonso.fr/api/v1/graphComp/graph?idhab=%d&auth_token=%@&type=%@", self.compare.habitatId, token, newEnergy];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.graphView loadRequest:request];
}

@end
