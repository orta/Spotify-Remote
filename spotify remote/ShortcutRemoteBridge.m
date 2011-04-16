//
//  ShortcutRemoteBridge.m
//  spotify remote
//
//  Created by orta on 15/04/2011.
//  Copyright 2011 http://www.ortatherox.com. All rights reserved.
//

#import "ShortcutRemoteBridge.h"
#import "SGHotKeyCenter.h"

@implementation ShortcutRemoteBridge

- (void) awakeFromNib{
  [self setHotKeyForControl:pauseRecorder hotkey:pauseHotKey withString:@"PauseHotkey" andSelector:@selector(pauseHit:)];
  [self setHotKeyForControl:togglePlayRecorder hotkey:togglePlayHotKey withString:@"TogglePlayHotkey" andSelector:@selector(togglePlayHit:)];
  [self setHotKeyForControl:previousRecorder hotkey:previousHotKey withString:@"PreviousHotkey" andSelector:@selector(previousHit:)];
  [self setHotKeyForControl:nextRecorder hotkey:nextHotKey withString:@"NextHotkey" andSelector:@selector(nextHit:)];
  
  hotkeyCallbackController = [[NSClassFromString(@"HotkeyCallbackController") alloc] init];
}

# pragma mark -
# pragma mark redirect methods

- (void)pauseHit:(id)sender {
  [hotkeyCallbackController pause];
}

- (void)togglePlayHit:(id)sender {
  [hotkeyCallbackController toggle_play];

}

- (void)previousHit:(id)sender {
  [hotkeyCallbackController previous];
}

- (void)nextHit:(id)sender {
  [hotkeyCallbackController next];

}


- (void) setHotKeyForControl: (SRRecorderControl *) control hotkey:(SGHotKey*)hotKey withString:(NSString*) key andSelector:(SEL)selector {
  [[SGHotKeyCenter sharedCenter] unregisterHotKey:hotKey];	

  id keyComboPlist = [[NSUserDefaults standardUserDefaults] objectForKey:key];
	SGKeyCombo *keyCombo = [[[SGKeyCombo alloc] initWithPlistRepresentation:keyComboPlist] autorelease];
	hotKey = [[SGHotKey alloc] initWithIdentifier:key keyCombo:keyCombo target:self action:selector];
	[[SGHotKeyCenter sharedCenter] registerHotKey:hotKey];
	[control setKeyCombo:SRMakeKeyCombo(hotKey.keyCombo.keyCode, [control carbonToCocoaFlags:hotKey.keyCombo.modifiers])];  
}


#pragma mark -
#pragma mark ShortcutRecorder Delegate Methods

- (BOOL)shortcutRecorder:(SRRecorderControl *)aRecorder isKeyCode:(NSInteger)keyCode andFlagsTaken:(NSUInteger)flags reason:(NSString **)aReason {	
	return NO;
}

- (void)shortcutRecorder:(SRRecorderControl *)recorder keyComboDidChange:(KeyCombo)newKeyCombo {
  SGKeyCombo *keyCombo = [SGKeyCombo keyComboWithKeyCode:[recorder keyCombo].code
                                               modifiers:[recorder cocoaToCarbonFlags:[recorder keyCombo].flags]];
	if (recorder == nextRecorder) {		
    [self saveKeyCombo: keyCombo on:nextHotKey forRecorder:nextRecorder withKey:@"NextHotkey"];
	} 
	if (recorder == previousRecorder) {		
    [self saveKeyCombo: keyCombo on:previousHotKey forRecorder:previousRecorder withKey:@"PreviousHotkey"];
	} 
	if (recorder == togglePlayRecorder) {		 
    [self saveKeyCombo: keyCombo on:togglePlayHotKey forRecorder:togglePlayRecorder withKey:@"TogglePlayHotkey"];
 	} 
	if (recorder == pauseRecorder) {		
    [self saveKeyCombo: keyCombo on:pauseHotKey forRecorder:pauseRecorder withKey:@"PauseHotkey"];
	} 
  }

- (void)saveKeyCombo:(SGKeyCombo *) keyCombo on:(SGHotKey*)hotkey forRecorder:(SRRecorderControl *)control withKey:(NSString *) key {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  hotkey.keyCombo = keyCombo;
  
	// Re-register the new hot key
  [[SGHotKeyCenter sharedCenter] registerHotKey: hotkey];
	[defaults setObject:[keyCombo plistRepresentation] forKey:key];
  [defaults synchronize];

}


- (void)finalize {
	[[NSUserDefaults standardUserDefaults] setObject:[pauseHotKey.keyCombo plistRepresentation] forKey:@"PauseHotkey"];
  [[NSUserDefaults standardUserDefaults] setObject:[togglePlayHotKey.keyCombo plistRepresentation] forKey:@"TogglePlayHotkey"];
  [[NSUserDefaults standardUserDefaults] setObject:[previousHotKey.keyCombo plistRepresentation] forKey:@"PreviousHotkey"];
  [[NSUserDefaults standardUserDefaults] setObject:[nextHotKey.keyCombo plistRepresentation] forKey:@"NextHotkey"];

}

@end
