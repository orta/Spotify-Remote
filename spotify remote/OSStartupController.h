//
//  OSStartupController..h
//  Tickifier
//
//  Created by orta on 17/10/2010.
//  Copyright 2010 http://www.ortatherox.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OSStartupController : NSObject {

}

- (BOOL)isLaunchAtStartup;
- (IBAction)toggleLaunchAtStartup:(id)sender;
- (LSSharedFileListItemRef)itemRefInLoginItems;

@end
