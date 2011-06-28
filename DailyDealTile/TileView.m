//
//  TileView.m
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import "TileView.h"

#define k_gameFieldTop 58.0f
#define k_gameFieldBottom 358.0f
#define k_gameFieldLeft 10.0f
#define k_gameFieldRight 310.0f

@implementation TileView

@synthesize tapRecognizer,
tileImg,
blackPos,
curGamePos,
delegate,
correctTilePos;


- (void)dealloc
{
    self.tapRecognizer = nil;
    self.tileImg = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andImg:(UIImage*)img
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.tileImg = img;
        [self setUpGestureRecognizer];
        [self setupImgView];
    }
    return self;
}

- (void) setupImgView 
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:tileImg];
    [self addSubview:imgView];
    [imgView release];
}

#pragma mark -
#pragma mark GestureSetUp

- (void) setUpGestureRecognizer 
{    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureTap:)];
    tapRecognizer.delegate = self;
    tapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapRecognizer];
}

- (void)handleGestureTap:(UITapGestureRecognizer *)recognizer
{
    [self checkGamePosition];
    
    float xMove = 0.0f;
    float yMove = 0.0f;
    
    if (canMoveLeft)
    {
        xMove = -100.0f;
    }
    else if (canMoveRight)
    {
        xMove = 100.0f;
    }
    else if (canMoveDown) 
    {
        yMove = 100.0f;
    }
    else if (canMoveUp)
    {
        yMove = -100.0f;
    }
    
    int tempCurPos = curGamePos;
    
    
    if (xMove != 0.0f || yMove != 0.0f)
    {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             self.frame = CGRectMake(self.frame.origin.x +xMove , self.frame.origin.y + yMove, self.frame.size.width, self.frame.size.height);
                             
                         } 
                         completion:^(BOOL finished){
                             curGamePos = blackPos;
                             [self blackPosChanged:tempCurPos];
                             
                         }];
    }
}

#pragma mark -
#pragma mark GamePlay

- (void) blackPosChanged:(int)pos 
{
    [delegate tilePosChanged:pos];
}

- (void) checkGamePosition {
    
    
    canMoveUp = NO;
    canMoveDown = NO;
    canMoveLeft = NO;
    canMoveRight = NO;
    
    if (curGamePos - 3 == blackPos)
    {
        canMoveUp = YES;
        canMoveDown = NO;
        canMoveLeft = NO;
        canMoveRight = NO;
        
        if (self.frame.origin.y == k_gameFieldTop)
        {
            canMoveUp = NO;
        }
    }
    else if (curGamePos + 3  == blackPos)
    {
        canMoveUp = NO;
        canMoveDown = YES;
        canMoveLeft = NO;
        canMoveRight = NO;
        
        
        if (self.frame.origin.y+self.frame.size.height == k_gameFieldBottom)
        {
            canMoveDown = NO;
        }
    } 
    else if (curGamePos - 1 == blackPos)
    {
        canMoveUp = NO;
        canMoveDown = NO;
        canMoveLeft = YES;
        canMoveRight = NO;
        
        if (self.frame.origin.x == k_gameFieldLeft)
        {
            canMoveLeft = NO;
        }
    }
    else if (curGamePos  +1 == blackPos)
    {
        canMoveUp = NO;
        canMoveDown = NO;
        canMoveLeft = NO;
        canMoveRight = YES;
        
        if (self.frame.origin.x+self.frame.size.width == k_gameFieldRight)
        {
            canMoveRight = NO;
        }
    }
}


@end
