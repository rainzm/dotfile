tell application "System Events" to tell process "OpenVPN Connect" to tell menu bar item 1 of menu bar 2
  click
  get menu items of menu 1
  try
    click menu item "Disconnect" of menu 1
    do shell script "echo OpenVPN disconnected"
  on error --menu item toggles between connect/disconnect
    key code 53 --escape key to close menu
    do shell script "echo Already disconnected"
  end try
end tell
