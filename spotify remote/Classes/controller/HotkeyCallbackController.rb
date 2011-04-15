#
#  HotkeyCallbackController.rb
#  spotify remote
#
#  Created by orta on 15/04/2011.
#  Copyright 2011 http://www.ortatherox.com. All rights reserved.
#


class HotkeyCallbackController
  
  def pause
      self.toggle_play
    self.performSelector("turn_on_after_timer:", withObject:self, afterDelay:300.0)
  end
  
  def turn_on_after_timer sender=nil
    self.toggle_play

  end

  def toggle_play
    # the grep & this shows in the results, hence 3    
    spotify_running =  `ps -A | grep Spotify.app | wc -l`.strip == "3" ? true : false
    if spotify_running
        resource_path = NSBundle.mainBundle.resourcePath
        `osascript "#{resource_path}/toggle_play_pause.scpt"`
    else
      #doing it this way means we don't care where it's installed
      `open "spotify:"`
    end    
  end
  
  def next
  resource_path = NSBundle.mainBundle.resourcePath
  `osascript "#{resource_path}/next.scpt" `

  end

  def previous
    resource_path = NSBundle.mainBundle.resourcePath
    `osascript "#{resource_path}/previous.scpt" `

  end
  
end