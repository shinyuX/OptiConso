//
//  OCChangerHabitatViewController.h
//  OptiConso
//
//  Created by Thomas COLLE on 12/9/12.
//  Copyright (c) 2012 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCListHabitatService.h"
#import "OCPickHabitatService.h"

@protocol ChangerViewDelegate <NSObject>
- (void)ChangerViewDidPickHabitat:(OCHabitat *)habitat;
@end

@interface OCChangerHabitatViewController : UITableViewController <UIAlertViewDelegate, LHCSDelegate, PHCSDelegate>

@property (strong, nonatomic) NSMutableArray *habitatList;
@property (strong, nonatomic) OCHabitat *pickedHabitat;
@property (assign, nonatomic) id<ChangerViewDelegate> delegate;
@property (strong, nonatomic) OCListHabitatService *LHCS;
@property (strong, nonatomic) OCPickHabitatService *PHCS;

- (void)LHCSDidFinishParsing:(NSMutableArray *)results;
- (void)LHCSDidNotFindAny;
- (void)LHCSDidEndWithError;

- (void)PHCSDidFinishParsing;
- (void)PHCSDidEndWithError;


@end
