//
//  OCConseilTableViewController.m
//  OptiConso
//
//  Created by  on 10/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OCConseilTableViewController.h"

@implementation OCConseilTableViewController

@synthesize waterTips;
@synthesize elecTips;
@synthesize gazTips;
@synthesize TCS;

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
    OCTip *tip1 = [[OCTip alloc] initWithType:OC_WATER_TIP name:@"Boire de l'eau" description:@"Il faut boire de l'eau sinon on meurt" rank:4];
    OCTip *tip2 = [[OCTip alloc] initWithType:OC_ELEC_TIP name:@"Les doigts dans la prise" description:@"Pas les doigts dans la prise sinon on meurt" rank:2];
    OCTip *tip3 = [[OCTip alloc] initWithType:OC_GAZ_TIP name:@"Respirer le gaz" description:@"Il ne faut pas respirer le gaz sinon on meurt" rank:0];
    
    self.waterTips = [[NSMutableArray alloc] initWithObjects:tip1, nil];
    self.elecTips = [[NSMutableArray alloc] initWithObjects:tip2, nil];
    self.gazTips = [[NSMutableArray alloc] initWithObjects:tip3, nil];
    
    self.TCS = [[OCTipsService alloc] initWithDelegate:self];
    [self.TCS launchConnection];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return [self.waterTips count];
            break;
            
        case 1:
            return [self.elecTips count];
            break;
            
        case 2:
            return [self.gazTips count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TipCell";
    OCTipCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[OCTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    OCTip *currentTip = nil;
    switch (indexPath.section) {
        case 0:
            currentTip = [self.waterTips objectAtIndex:[indexPath row]];
            break;
            
        case 1:
            currentTip = [self.elecTips objectAtIndex:[indexPath row]];
            break;
            
        case 2:
            currentTip = [self.gazTips objectAtIndex:[indexPath row]];
            break;
            
        default:
            break;
    }

    cell.titleLabel.text = currentTip.tipName;
    cell.descLabel.text = currentTip.tipDescription;
    
    if (currentTip.tipRank > 0)
        cell.star1.image = [UIImage imageNamed:@"star_yellow.png"];
    if (currentTip.tipRank > 1)
        cell.star2.image = [UIImage imageNamed:@"star_yellow.png"];
    if (currentTip.tipRank > 2)
        cell.star3.image = [UIImage imageNamed:@"star_yellow.png"];
    if (currentTip.tipRank > 3)
        cell.star4.image = [UIImage imageNamed:@"star_yellow.png"];
    if (currentTip.tipRank > 4)
        cell.star5.image = [UIImage imageNamed:@"star_yellow.png"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - TipsConnectionService delegate

- (void)TCSDidFinishParsing:(NSMutableArray *)results
{
    for (OCTip *tip in results)
    {
        switch (tip.tipType) {
            case OC_ELEC_TIP:
                [self.elecTips addObject:tip];
                break;
                
            case OC_GAZ_TIP:
                [self.gazTips addObject:tip];
                break;

            case OC_WATER_TIP:
                [self.waterTips addObject:tip];
                break;

            default:
                break;
        }
    }
    [self.tableView reloadData];
}

- (void)TCSDidEndWithError
{
    NSString *title = NSLocalizedString(@"Une erreur est survenue.", @"");
    NSString *message = NSLocalizedString(@"La recuperationdes donnees a echoue. Veuillez verifier votre connexion internet et reessayer ulterieurement.", @"");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)TCSDidEndWithoutResult
{
    NSString *title = NSLocalizedString(@"Pas de resultat.", @"");
    NSString *message = NSLocalizedString(@"Il n'y a aucun nouveau conseil disponible.", @"");
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
