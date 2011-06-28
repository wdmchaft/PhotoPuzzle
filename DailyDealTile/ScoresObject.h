//
//  ScoresObject.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011 HTW Berlin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoresObject : NSObject {
    
    NSString *scoresString;
    NSString *nameString;
}

@property (nonatomic, retain) NSString *scoresString;
@property (nonatomic, retain) NSString *nameString;

@end
