//
//  OCComparerViewController.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/12/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCComparerViewController.h"

@implementation OCComparerViewController
@synthesize compareList;
@synthesize compare;
@synthesize LCCS;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-color.jpeg"]];
    
    self.LCCS = [[OCListCompareService alloc] initWithDelegate:self];
    self.compareList = [[NSMutableArray alloc] init];
    
    [self.LCCS launchConnection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.compareList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompareCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    OCCompare *currentCompare = [self.compareList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", currentCompare.userName, currentCompare.habitatName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d m2", currentCompare.habitatSurface];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.compare = [self.compareList objectAtIndex:indexPath.row];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CompareSegue"])
    {
        OCComparerViewController *compareView = segue.destinationViewController; 
        compareView.compare = self.compare;
    }
}

#pragma mark - OCListHabitatService Delegate

- (void)LCCSDidFinishParsing:(NSMutableArray *)results
{
    [self.compareList addObjectsFromArray:results];
    [self.tableView reloadData];
}

- (void)LCCSDidNotFindAny
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"Aucun habitat comparable au votre n'a ete trouve.", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)LCCSDidEndWithError
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"La recuperation des habitats a comparer a echoue. Veuillez verifier votre connexion internet et reessayer ulterieurement.", @"");
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
