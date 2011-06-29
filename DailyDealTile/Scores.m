//
//  Scores.m
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import "Scores.h"


@implementation Scores

@synthesize scoresArray;

- (void) dealloc
{
    self.scoresArray = nil;
    [super dealloc];
}

- (id) init 
{
    if ((self = [super init])) 
    {
        scoresArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark 
#pragma mark NSCodingDelegates
- (id)initWithCoder:(NSCoder *)decoder {
    
    if (![super init]) 
    {
        return nil;
    }
    
    [self setScoresArray:[decoder decodeObjectForKey:@"allScores"]];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:[self scoresArray] forKey:@"allScores"];
    
}

- (void) addScores:(ScoresObject*)obj {
    [scoresArray addObject:obj];
}

@end
