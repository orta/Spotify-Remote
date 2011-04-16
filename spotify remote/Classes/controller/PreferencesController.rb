#
#  PreferencesController.rb
#  spotify remote
#
#  Created by orta on 16/04/2011.
#  Copyright 2011 http://www.ortatherox.com. All rights reserved.
#


class PreferencesController < NSViewController

  def toggle_load_on_startup sender
    OSStartupController.toggleLaunchAtStartup self
  end
  
  def get_open_at_startup
    OSStartupController.isLaunchAtStartup
  end
  
end