//
//  ShortcutRemoteBridge.h
//  spotify remote
//
//  Created by orta on 15/04/2011.
//  Copyright 2011 http://www.ortatherox.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShortcutRecorder/ShortcutRecorder.h>
#import "SGHotKey.h"

@interface ShortcutRemoteBridge : NSObject {
  IBOutlet SRRecorderControl *pauseRecorder;
  IBOutlet SRRecorderControl *togglePlayRecorder;
  IBOutlet SRRecorderControl *previousRecorder;
  IBOutlet SRRecorderControl *nextRecorder;  
  SGHotKey *pauseHotKey;
  SGHotKey *togglePlayHotKey;
  SGHotKey *nextHotKey;  
  SGHotKey *previousHotKey;
  id hotkeyCallbackController;
}

- (void) setHotKeyForControl: (SRRecorderControl *) control hotkey:(SGHotKey*)hotKey withString:(NSString*) key andSelector:(SEL)selector;
- (void)saveKeyCombo:(SGKeyCombo *) keyCombo on:(SGHotKey*)hotkey forRecorder:(SRRecorderControl *)control withKey:(NSString *) key;

- (void) applicationWillTerminate:(NSNotification *)theNotification;

@end
