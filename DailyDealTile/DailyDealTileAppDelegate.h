//
//  DailyDealTileAppDelegate.h
//  DailyDealTile
//
//  Created by Sebastian Muggelberg on 28.06.11.
//  Copyright 2011  Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DailyDealTileViewController;

@interface DailyDealTileAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DailyDealTileViewController *viewController;

@end
