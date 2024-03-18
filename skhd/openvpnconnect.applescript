tell application "System Events" to tell process "OpenVPN Connect" to tell menu bar item 1 of menu bar 2
  click
  get menu items of menu 1
  try
    click menu item "Connect" of menu 1
    do shell script "echo OpenVPN ready to connect"
  on error --menu item toggles between connect/disconnect
    key code 53 --escape key to close menu
    do shell script "echo Already connected"
  end try
end tell
