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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-color.jpeg"]];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.waterTips = [[NSMutableArray alloc] init];
    self.elecTips = [[NSMutableArray alloc] init];
    self.gazTips = [[NSMutableArray alloc] init];

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
            return [self.waterTips count] + 1;
            break;
            
        case 1:
            return [self.elecTips count] + 1;
            break;
            
        case 2:
            return [self.gazTips count] + 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return 22.0;
    else
        return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"TipSeparatorCell";
        OCTipSeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[OCTipSeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        switch (indexPath.section) {
            case 0:
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.5 green:0.66 blue:0.88 alpha:1.0];
                cell.titleLabel.textColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.6 alpha:1.0];
                cell.titleLabel.text = @"Eau";
                break;
                
            case 1:
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0.85 blue:0.1 alpha:1.0];
                cell.titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.0 alpha:1.0];
                cell.titleLabel.text = @"Electricite";
                break;
                
            case 2:
                cell.contentView.backgroundColor = [UIColor colorWithRed:0.25 green:0.67 blue:0.27 alpha:1.0];
                cell.titleLabel.textColor = [UIColor colorWithRed:0.0 green:0.3 blue:0.0 alpha:1.0];
                cell.titleLabel.text = @"Gaz";
                break;
                
            default:
                break;
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    } else {
        static NSString *CellIdentifier = @"TipCell";
        OCTipCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (cell == nil) {
            cell = [[OCTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        OCTip *currentTip = nil;
        switch (indexPath.section) {
            case 0:
                currentTip = [self.waterTips objectAtIndex:([indexPath row] - 1)];
                break;
            
            case 1:
                currentTip = [self.elecTips objectAtIndex:([indexPath row] - 1)];
                break;
            
            case 2:
                currentTip = [self.gazTips objectAtIndex:([indexPath row] - 1)];
                break;
            
            default:
                break;
        }

        cell.titleLabel.text = currentTip.tipName;
        cell.descLabel.text = currentTip.tipDescription;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
