//
//  FeedItems.h
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//
//  FeedItems - The collection of each FeedItem pulled down and stored from the webserver

#import <Foundation/Foundation.h>
#import "FeedItem.h"

@interface FeedItems : NSObject

+ (id)sharedInstance;

- (BOOL)anyNewItems;
- (FeedItem *)feedItemForRow:(int)row;
- (int)count;

@end
