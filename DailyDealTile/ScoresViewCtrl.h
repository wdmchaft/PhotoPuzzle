//
//  ScoresViewCtrl.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scores.h"


@interface ScoresViewCtrl : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *scoreTableView;
    IBOutlet UIToolbar* topToolBar;
    IBOutlet UIBarButtonItem* backButton;
    
    Scores *allScores;
}

@property (nonatomic, retain) IBOutlet UITableView *scoreTableView;
@property (nonatomic, retain) IBOutlet UIToolbar* topToolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* backButton;
@property (nonatomic, retain) Scores *allScores;


- (id)initWithNibName:(NSString *)nibNameOrNil andScores:(Scores*)scr;
- (void) sortByScores;
- (IBAction) backButtonClicked;

@end
