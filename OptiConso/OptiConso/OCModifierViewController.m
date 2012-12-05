//
//  OCModifierViewController.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/5/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCModifierViewController.h"

@implementation OCModifierViewController

@synthesize delegate;
@synthesize energySC;
@synthesize datePicker;
@synthesize valueField;

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
//    self.energySC.segmentedControlStyle = UISegmentedControlStyleBar;
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.valueField isFirstResponder])
        [self.valueField resignFirstResponder];
    if ([self.datePicker isFirstResponder])
        [self.datePicker resignFirstResponder];
}

- (IBAction)validateButton:(id)sender
{
    if ([[self.valueField text] isEqualToString:@""])
    {
        NSString *title = NSLocalizedString(@"Champ de valeur non rempli.", @"");
        NSString *message = NSLocalizedString(@"Le champ concernant la valeur de votre consomation a été laissé vide. Veuillez le remplir.", @"");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (![[NSScanner scannerWithString:[self.valueField text]] scanInt:nil])
    {
        NSString *title = NSLocalizedString(@"Valeur invalide.", @"");
        NSString *message = NSLocalizedString(@"La valeur de votre consommation n'est pas correcte. Veuillez entrer un entier.", @"");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:[self.datePicker date]];
        [self.delegate ModifierViewDidAddValue:[[self.valueField text] integerValue] forEnergy:[self.energySC selectedSegmentIndex] date:dateString];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        default:
            break;
    }
}

@end
