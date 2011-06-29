//
//  TileView.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TileViewDelegate <NSObject>

- (void) tilePosChanged:(int)pos;

@end

@interface TileView : UIView <UIGestureRecognizerDelegate>{
    
    
    id<TileViewDelegate> delegate;
    
    UITapGestureRecognizer *tapRecognizer;
    UIImage *tileImg;
    CGPoint lastPoint;
    
    BOOL canMoveLeft;
    BOOL canMoveRight;
    BOOL canMoveDown;
    BOOL canMoveUp;
    
    int blackPos;
    int curGamePos;
    int correctTilePos;
}

@property (nonatomic, retain) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, retain) UIImage *tileImg;
@property (nonatomic, assign) int blackPos;
@property (nonatomic, assign) int curGamePos;
@property (nonatomic, assign) int correctTilePos;
@property (nonatomic, assign) id<TileViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andImg:(UIImage*)img;
- (void) setupImgView;
- (void) setUpGestureRecognizer;
- (void)handleGestureTap:(UITapGestureRecognizer *)recognizer;
- (void) checkGamePosition;
- (void) blackPosChanged:(int)pos;


@end
