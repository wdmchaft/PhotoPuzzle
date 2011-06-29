//
//  ScoresObject.m
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import "ScoresObject.h"


@implementation ScoresObject

@synthesize scoresString,
nameString;

- (void) dealloc 
{
    self.scoresString = nil;
    self.nameString = nil;
    [super dealloc];
}

#pragma mark 
#pragma mark NSCodingDelegates
- (id)initWithCoder:(NSCoder *)decoder {
    
    if (![super init]) 
    {
        return nil;
    }
    
    [self setNameString:[decoder decodeObjectForKey:@"name"]];
    [self setScoresString:[decoder decodeObjectForKey:@"score"]];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:[self nameString] forKey:@"name"];
    [encoder encodeObject:[self scoresString] forKey:@"score"];
}

@end
