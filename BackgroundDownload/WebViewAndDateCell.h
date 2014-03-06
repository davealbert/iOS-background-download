//
//  WebViewAndDateCell.h
//  BackgroundDownload
//
//  Created by Dave Albert on 06/03/2014.
//  Copyright (c) 2014 Dave Albert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewAndDateCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;

@end
