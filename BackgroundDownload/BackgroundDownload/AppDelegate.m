//
//  AppDelegate.m
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedItems.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  // This is a very short FetchInterval and only for testing.
  [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:1.0];

  return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//  [[FeedItems sharedInstance] anyNewItems];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
  // Perform background fecth of data on a schedule so app data is up to date on each use -- dependant on schedule
  NSLog(@"performFetchWithCompletionHandler -- FeedItems checking for anyNewItems");
  BOOL newData = [[FeedItems sharedInstance] anyNewItems];

  if (completionHandler) {
    completionHandler(newData);
  }
}

@end
