//
//  FeedItems.m
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import "FeedItems.h"

@interface FeedItems () {
  NSMutableArray *arrayOfFeeds;
}

@end


@implementation FeedItems

#pragma mark - Initialization Methods

// We only want one instance of this class, and it should be persistant
+ (id)sharedInstance {
  static dispatch_once_t p = 0;

  __strong static id _sharedObject = nil;

  dispatch_once(&p, ^{
    _sharedObject = [[self alloc] init];
  });

  return _sharedObject;
}

- (id)init {
  self = [super init];
  if (self) {
    arrayOfFeeds = [[NSMutableArray alloc] init];
    [self anyNewItems];
  }
  return self;
}

- (BOOL)anyNewItems {
  NSLog(@"anyNewItems");

  [arrayOfFeeds insertObject:[[FeedItem alloc] initWithNumber:[arrayOfFeeds count] + 1 withCallback:^{
    // Post notification once the webdata has been stored
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NewItemAddedToBackgroundDownloadFeed" object:nil];
  }] atIndex:0];

  return NO;
}

- (FeedItem *)feedItemForRow:(int)row {
  if ([arrayOfFeeds count] > row) {
    return [arrayOfFeeds objectAtIndex:row];
  } else {
    NSAssert(!([arrayOfFeeds count] > row), @"Index row greater than count of arrayOfFeeds");
  }

  return nil;
}

- (int)count {
  return [arrayOfFeeds count];
}

@end
