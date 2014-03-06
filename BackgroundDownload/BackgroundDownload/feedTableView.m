//
//  feedTableView.m
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import "feedTableView.h"
#import "WebViewAndDateCell.h"

@implementation feedTableView

#pragma mark - Initialization methods

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self commonInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Initialization code
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  [self setDelegate:self];
  [self setDataSource:self];
}

#pragma mark - TableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // TODO: Correct numberOfRowsInSection
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *WebViewAndDateCellIdentifier = @"WebViewAndDateCell";
  WebViewAndDateCell *cell = [tableView dequeueReusableCellWithIdentifier:WebViewAndDateCellIdentifier];

  // TODO: Correct cellForRowAtIndexPath
  [cell.timestampLabel setText:@"foo"];
  return cell;
}

#pragma mark - TableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
