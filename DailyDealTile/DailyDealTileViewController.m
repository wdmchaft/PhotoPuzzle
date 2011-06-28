//
//  DailyDealTileViewController.m
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import "DailyDealTileViewController.h"
#import "UIImage+Resize.h"
#import "ScoresViewCtrl.h"


@implementation DailyDealTileViewController

@synthesize pictureBtn,
tilesArray,
cameraBtn,
camToolBar,
scoresBtn,
helpBtn,
puzzleImg,
countLabel,
scoresTextField,
scoresView,
scores;

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.pictureBtn = nil;
    self.cameraBtn = nil;
    self.camToolBar = nil;
    self.scoresBtn = nil;
    self.helpBtn = nil;
    self.countLabel = nil;
    self.scoresTextField = nil;
    self.scoresView = nil;
}

- (void)dealloc
{
    self.cameraBtn = nil;
    self.tilesArray = nil;
    self.pictureBtn = nil;
    self.camToolBar = nil;
    self.scoresBtn = nil;
    self.helpBtn = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.puzzleImg = nil;
    self.countLabel = nil;
    self.scoresTextField =nil;
    self.scoresView = nil;
    self.scores = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tilesArray = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifMethod:) name:@"dissmissModalView" object:nil];    
    [self setupArchiver];
}


- (void) setupArchiver
{
    self.scores = nil;
    self.scores = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForFile:@"scores.archive"]]; 
    if (scores == nil)
    {
        scores = [[Scores alloc] init];
    }
}

- (void) notifMethod:(NSNotification*)aNotification 
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark - TileCalculation

- (void) tilingImage:(UIImage*)img 
{
    //if array exists with elements removeAll
    if ([tilesArray count] > 0)
    {
        [tilesArray removeAllObjects];
    }
    
    //this version tiles an 300x300px img into 9 different parts and stores them in tilesArray
    
    //loop for x and y coordsystem :)
    for (int x = 0; x < 3; x++)
    {
        for (int y = 0; y < 3 ; y++)
        {
            UIImage *tileImg = [img croppedImage:CGRectMake(x*100.0f, y*100.0f, 100.0f, 100.0f)];
            
            TileView *tileView = [[TileView alloc] initWithFrame:CGRectMake(10,58, 100.0f, 100.0f) andImg:tileImg];
            tileView.correctTilePos = y*3+x;
            
            //[tilesArray addObject:tileImg];
            [tilesArray addObject:tileView];
        }
    }
    
    [tilesArray removeLastObject];
    blackPos = 8;
}

- (void) positioningTiles 
{
    
    int count = [tilesArray count];
    
    if (count > 0 && tilesArray)
    {
        //reorder array for random positioning 
        for (int i = 0; i < count; ++i) {

            int elements = count - i;
            int n = (random() % elements) + i;
            [tilesArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    
        //remove old imgViews if exist
        [self removeTiles];
        
        //positioning of the tiles
        for (int i = 0; i < count; i++)
        {
            //TileView *tileView = [[TileView alloc] initWithFrame:CGRectMake(10+((i%3)*100.0f),58+(((int)(i/3))*100.0f), 100.0f, 100.0f) andImg:[tilesArray objectAtIndex:i]];
            TileView *tileView = [tilesArray objectAtIndex:i];
            tileView.frame = CGRectMake(10+((i%3)*100.0f),58+(((int)(i/3))*100.0f), 100.0f, 100.0f);
            tileView.tag = 100+i;
            tileView.blackPos = blackPos;
            tileView.delegate = self;
            tileView.curGamePos = i;
            [self.view addSubview:tileView];
            [tileView release];
        }
    }
}

- (void) removeTiles 
{
    //remove old imgViews if exist
    for (int i = 0; i < [tilesArray count] ; i++) 
    {
        if ([[self.view viewWithTag:100+i] isKindOfClass:[TileView class]])
        {
            [[self.view viewWithTag:100+i] removeFromSuperview];
        }
    }
    
    //remove the old helpView
    if ([self.view viewWithTag:1337])
    {
        [[self.view viewWithTag:1337] removeFromSuperview];
    }
}

#pragma mark -
#pragma mark TileViewDelegate

- (void) tilePosChanged:(int)pos 
{
    blackPos = pos;
    
    BOOL isFinished = YES;
    
    //set the new blackpos to all subviews && check for correctnes
    for (int i = 0; i < [tilesArray count] ; i++) 
    {
        if ([[self.view viewWithTag:100+i] isKindOfClass:[TileView class]])
        {
            ((TileView*)[self.view viewWithTag:100+i]).blackPos = blackPos;
        }
        
        if (((TileView*)[self.view viewWithTag:100+i]).curGamePos != ((TileView*)[self.view viewWithTag:100+i]).correctTilePos)
        {
            isFinished = NO;
        }
    }
    
    //set counterLabel
    curScores ++;
    countLabel.text = [NSString stringWithFormat:@"Number of Touches %i",curScores];
    
    if (isFinished)
    {
        [self gameFinished];
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
   
    
    puzzleImg = [[UIImage alloc] initWithCGImage:[(UIImage*)[info objectForKey:@"UIImagePickerControllerOriginalImage"] thumbnailImage:300.0f transparentBorder:0.0f cornerRadius:0.0f interpolationQuality:0].CGImage];   
    [self tilingImage:puzzleImg];
    [self positioningTiles];
    [self dismissModalViewControllerAnimated:YES];
    
    countLabel.text = [NSString stringWithFormat:@"Number of Touches 0",curScores];
    curScores = 0;
}

#pragma mark
#pragma mark Finishing

- (void) gameFinished 
{
    [self.view bringSubviewToFront:scoresView];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut 
                     animations:^{
                         scoresView.alpha = 1.0f;

                     } 
                     completion:^(BOOL finished){
                         
                     }];

}

#pragma mark 
#pragma mark TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{

    [self saveScore];
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut 
                     animations:^{
                         scoresView.alpha = 0.0f;
                         
                     } 
                     completion:^(BOOL finished){
                         [self scoresBtnClicked];
                         scoresTextField.text = @"";
                         [self removeTiles];
                         countLabel.text = @"";
                     }];
    return YES;
}

- (void) saveScore 
{
    //normaly this would not be saved in the user defaults but for this test it is fast and works
    ScoresObject *scoresObject = [[ScoresObject alloc] init];
    scoresObject.scoresString = [NSString stringWithFormat:@"%i",curScores];
    scoresObject.nameString = scoresTextField.text;
    [scores addScores:scoresObject];
    [scoresObject release];
    
    [NSKeyedArchiver archiveRootObject:scores toFile:[self pathForFile:@"scores.archive"]];
}

- (NSString*) pathForFile:(NSString*)fileName 
{
    NSArray *deviceTxtDocumentsDirectory=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *deviceDirectory=[deviceTxtDocumentsDirectory objectAtIndex:0];
    NSString *path =[deviceDirectory stringByAppendingPathComponent:fileName];
    
    return path;
}

#pragma mark -
#pragma mark Actions
- (IBAction) pictureBtnClicked
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:picker animated:YES];
    [picker release];

}

- (IBAction) cameraBtnClicked 
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

- (IBAction) scoresBtnClicked 
{
    ScoresViewCtrl *viewCtrl = [[ScoresViewCtrl alloc] initWithNibName:@"ScoresViewCtrl" andScores:scores];
    viewCtrl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:viewCtrl animated:YES];
    [viewCtrl release];
    
}

- (IBAction) helpBtnClicked 
{
    if (puzzleImg)
    {
        if ([self.view viewWithTag:1337])
        {
            [[self.view viewWithTag:1337] removeFromSuperview];
        }
        
        UIImageView *helpView = [[UIImageView alloc] initWithImage:puzzleImg];
        helpView.frame = CGRectMake(10.0f, 58.0f, 300.0f, 300.0f);
        helpView.alpha = 0.2;
        helpView.tag = 1337;
        [self.view addSubview:helpView];
        [helpView release];
        
        [self.view sendSubviewToBack:[self.view viewWithTag:1337]];
    }
}


@end
