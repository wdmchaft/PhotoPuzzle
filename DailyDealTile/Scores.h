//
//  Scores.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoresObject.h"

@interface Scores : NSObject {

    NSMutableArray *scoresArray;
}

@property(nonatomic, retain) NSMutableArray *scoresArray;

- (void) addScores:(ScoresObject*)obj;

@end
