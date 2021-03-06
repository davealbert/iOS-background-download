//
//  FeedItem.h
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate, NSCoding>

@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) NSString *filename;


- (NSData *)dataForWebview;
- (NSString *)timestampString;
- (id)initWithNumber:(int)number withCallback:(void(^)(void))callback;

@end
