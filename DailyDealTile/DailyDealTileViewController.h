//
//  DailyDealTileViewController.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"
#import "ScoresObject.h"
#import "Scores.h"


@interface DailyDealTileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TileViewDelegate, UITextFieldDelegate> {
 
    IBOutlet UIBarButtonItem *pictureBtn;
    IBOutlet UIBarButtonItem *cameraBtn;
    IBOutlet UIBarButtonItem *scoresBtn;
    IBOutlet UIBarButtonItem *helpBtn;
    IBOutlet UILabel *countLabel;
    IBOutlet UITextField *scoresTextField;
    IBOutlet UIView *scoresView;
    
    IBOutlet UIToolbar *camToolBar;
    
    NSMutableArray *tilesArray;
    
    int blackPos;
    
    UIImage *puzzleImg;
    int curScores;
    
    Scores *scores;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *pictureBtn;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *cameraBtn;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *scoresBtn;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *helpBtn;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) IBOutlet UITextField *scoresTextField;
@property (nonatomic, retain) IBOutlet UIView *scoresView;
@property (nonatomic, retain) Scores *scores;

@property (nonatomic, retain) IBOutlet UIToolbar *camToolBar;
@property (nonatomic, retain) NSMutableArray *tilesArray;
@property (nonatomic, retain) UIImage *puzzleImg;

- (void) notifMethod:(NSNotification*)aNotification;
- (void) setupArchiver;
- (void) tilingImage:(UIImage*)img;
- (void) removeTiles;
- (void) gameFinished;
- (void) saveScore;
- (NSString*) pathForFile:(NSString*)fileName;
- (IBAction) pictureBtnClicked;
- (IBAction) cameraBtnClicked;
- (IBAction) scoresBtnClicked;
- (IBAction) helpBtnClicked;

@end
