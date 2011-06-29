//
//  ScoresViewCtrl.m
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import "ScoresViewCtrl.h"
#import "ScoresObject.h"


@implementation ScoresViewCtrl

@synthesize scoreTableView,
topToolBar,
backButton,
allScores;


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.scoreTableView = nil;
    self.topToolBar = nil;
    self.backButton = nil;
    
}

- (void)dealloc
{
    self.scoreTableView = nil;
    self.topToolBar = nil;
    self.backButton = nil;
    self.allScores = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil andScores:(Scores*)scr {

    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        // Custom initialization
        self.allScores = scr;
        [self sortByScores];
    }
    
    return self;
}

#pragma mark 
#pragma mark sorting

static NSInteger sortScoresByScores(id obj1, id obj2, void *context)
{
    
    return [[NSNumber numberWithInt:[[obj1 scoresString] intValue]] compare:[NSNumber numberWithInt:[[obj2 scoresString] intValue]]];
}

- (void) sortByScores
{
    allScores.scoresArray = [NSMutableArray arrayWithArray:[allScores.scoresArray sortedArrayUsingFunction:sortScoresByScores context:NULL]];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [allScores.scoresArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [(ScoresObject*)[allScores.scoresArray objectAtIndex:indexPath.row] nameString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Movements: %@",[(ScoresObject*)[allScores.scoresArray objectAtIndex:indexPath.row] scoresString]];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}


#pragma mark -
#pragma mark Actions

- (IBAction) backButtonClicked
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"dissmissModalView" object:nil];
}



@end
