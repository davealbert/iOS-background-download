//
//  FeedItem.m
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import "FeedItem.h"
#import "FileHelper.h"

@interface FeedItem() {
  NSDateFormatter *dateFormater;
  NSMutableData *receivedData;
  NSStringEncoding encoding;
  id initComplete;
}

@end


@implementation FeedItem

#pragma mark - Initialization Methods

- (id)initWithNumber:(int)number withCallback:(void(^)(void))callback {
  self = [super init];
  if (self) {
    initComplete = [callback copy];
    self.timestamp = [NSDate date];
    self.filename = [NSString stringWithFormat:@"File%d.dat", number];
    NSURL *url = [NSURL URLWithString:@API_URL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    // We don't need a referance to the connection.
    (void)[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
  }
  return self;
}

#pragma mark - Archiver Methods

- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
    self.timestamp = [decoder decodeObjectForKey:@"timestamp"];
    self.filename = [decoder decodeObjectForKey:@"filename"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.timestamp forKey:@"timestamp"];
  [encoder encodeObject:self.filename forKey:@"filename"];
}

#pragma mark - Public FeedItem Methods

- (NSData *)dataForWebview {
  return [NSData dataWithContentsOfFile:[FileHelper pathForName:self.filename]];
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
    [dateFormater setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
  }

  return dateFormater;
}

#pragma mark - NSURL Connection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  // every response could mean a redirect
	receivedData = nil;
  encoding = CFStringConvertEncodingToNSStringEncoding(NSASCIIStringEncoding);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if (!receivedData) {
    // no store yet, make one
		receivedData = [[NSMutableData alloc] initWithData:data];
  } else {
    // append to previous chunks
		[receivedData appendData:data];
  }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  // Save Data
  [receivedData writeToFile:[FileHelper pathForName:self.filename] atomically:YES];
  if (initComplete) {
    void(^completion)() = initComplete;
    completion();
  }
}

// An error occured
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Error retrieving data, %@", [error localizedDescription]);
}

// to deal with self-signed certificates
- (BOOL)connection:(NSURLConnection *)connection
canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod
          isEqualToString:NSURLAuthenticationMethodServerTrust];
}


@end
