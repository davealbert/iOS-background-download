//
//  FeedItem.m
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import "FeedItem.h"

@interface FeedItem() {
  NSDateFormatter *dateFormater;
}

@end


@implementation FeedItem

#pragma mark - Initialization Methods

- (id)init {
  self = [super init];
  if (self) {
    self.timestamp = [NSDate date];
  }
  return self;
}

#pragma mark - Public FeedItem Methods

- (NSData *)dataForWebview {
  // TODO: return data from web stored in self.filename
  return nil;
}

- (NSString *)timestampString {
  if (self.timestamp) {
    return [[self dateFormater] stringFromDate:self.timestamp];
  } else {
    return @"<Missing date>";
  }
}

#pragma mark - Lazy loader methods

- (NSDateFormatter *)dateFormater {
  if (!dateFormater) {
    dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
  }

  return dateFormater;
}

@end
