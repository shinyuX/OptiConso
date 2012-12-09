//
//  OCChangerHabitatViewController.m
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import "OCChangerHabitatViewController.h"


@implementation OCChangerHabitatViewController
@synthesize habitatList;
@synthesize pickedHabitat;
@synthesize LHCS;
@synthesize PHCS;
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-color.jpeg"]];
    
    self.LHCS = [[OCListHabitatService alloc] initWithDelegate:self];
    self.PHCS = [[OCPickHabitatService alloc] initWithDelegate:self];
    self.habitatList = [[NSMutableArray alloc] init];

    [self.LHCS launchConnection];
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
    return [self.habitatList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HabitatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    OCHabitat *currentHabitat = [self.habitatList objectAtIndex:indexPath.row];
    if (currentHabitat.isSelected)
        cell.detailTextLabel.text = @"Habitat actuel";
    else
        cell.detailTextLabel.text = @"";
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %d m2", currentHabitat.habitatName, currentHabitat.habitatSurface];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OCHabitat *selectedHabitat = [self.habitatList objectAtIndex:indexPath.row];
    if (selectedHabitat.isSelected)
        [self.delegate ChangerViewDidPickHabitat:selectedHabitat];
    else
        [self.PHCS launchConnectionForHabitat:selectedHabitat];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        default:
            break;
    }
}

#pragma mark - OCListHabitatService Delegate

- (void)LHCSDidFinishParsing:(NSMutableArray *)results
{
    [self.habitatList addObjectsFromArray:results];
    [self.tableView reloadData];
}

- (void)LHCSDidNotFindAny
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"Vous ne possedez aucun habitat. Veuillez en ajouter un sur opticonso.fr", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)LHCSDidEndWithError
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"La recuperation de la liste de vos habitats a echoue. Veuillez verifier votre connexion internet et reessayer ulterieurement.", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - OCPickHabitatService Delegate

- (void)PHCSDidFinishParsing
{
    [self.delegate ChangerViewDidPickHabitat:self.pickedHabitat];
}

- (void)PHCSDidEndWithError
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"Le choix d'un nouvel habitat a suivre a echoue. Veuillez verifier votre connexion internet et reessayer ulterieurement.", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
