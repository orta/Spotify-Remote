#
#  AppDelegate.rb
#  spotify remote
#
#  Created by orta on 15/04/2011.
#  Copyright 2011 http://www.ortatherox.com. All rights reserved.
#

class AppDelegate
  attr_accessor :window
    
  def awakeFromNib 
    puts "started"
    create_status_bar_item
    create_view_controller
  end
  
  def create_status_bar_item
    @statusItem = NSStatusBar.systemStatusBar.statusItemWithLength NSVariableStatusItemLength
    image = NSImage.imageNamed "spotify_remote_menu_icon.png"
    @statusItem.image = image
    @statusItem.enabled = true
    @statusItem.highlightMode = true
    @statusItem.action = "menu_item_clicked:"
    @statusItem.target = self
    @statusItem.toolTip = "Spotify Remote"
  end
  
  def create_view_controller
    viewController = PreferencesController.alloc.initWithNibName "Preferences", bundle:nil
    @popoverController = INPopoverController.alloc.initWithContentViewController viewController
    
    @popoverController.closesWhenPopoverResignsKey = true;
    @popoverController.color = NSColor.colorWithCalibratedWhite 1.0, alpha:0.8
    @popoverController.borderColor = NSColor.blackColor
    @popoverController.borderWidth = 2.0;
  end
  
  def menu_item_clicked sender
    buttonBounds = sender.bounds
    point = NSMakePoint(NSMidX(buttonBounds), NSMaxY(buttonBounds))
    @popoverController.showPopoverAtPoint point, inView:sender, preferredArrowDirection:3, anchorsToPositionView:true
  
  end
end