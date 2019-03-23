#!/usr/bin/osascript

on openAirdropWindow()
	-- https://github.com/canalnoises/AirDrop-AppleScript
	tell application "System Events" to tell process "Finder"
		set shareButton to (first button whose description is "Share") of toolbar 1 of window 1
		ignoring application responses
			click shareButton
			delay 0.1
		end ignoring
	end tell
	
	do shell script "killall 'System Events'"
	
	tell application "System Events" to tell process "Finder"
		click (menu item "AirDrop") of menu 1 of (first button whose description is "Share") of toolbar 1 of window 1
		repeat until window "AirDrop" exists
		end repeat
	end tell
end openAirdropWindow

on run argv
	if (count of argv) is not 3 then
		tell application "System Events" to set theFrontmost to name of first process whose frontmost is true
		if theFrontmost = "Script Editor" then
			-- Likely invoked from Script Editor. Supply some default arguments to simplify testing
			set argv to {"/usr/bin/true", "Kabir Oberai", "iPad"}
		else
			log "Usage: " & (my name as string) & " <path to file> <device name> <device type>"
			return
		end if
	end if
	
	set theFilePath to item 1 of argv
	set theFile to POSIX file theFilePath
	
	set theDeviceName to item 2 of argv
	set theDeviceType to item 3 of argv
	set theDevice to {theDeviceName, theDeviceType}
	
	tell application "Finder" to reveal theFile
	
	delay 0.2
	
	openAirdropWindow()
	
	tell application "System Events" to tell process "Finder" to tell window "AirDrop" to repeat
		repeat until scroll area 1 exists
			if not (exists) then -- if the user manually closes the AirDrop window
				delay 0.1
				close window 1 of application "Finder"
				return
			end if
		end repeat
		repeat with theElement in UI element 1 of rows of table 1 of scroll area 1
			set theTexts to value of every static text of theElement
			if theTexts is equal to theDevice then
				click theElement
				repeat until button "Done" exists
				end repeat
				click button "Done"
				delay 0.1
				close window 1 of application "Finder"
				return
			end if
		end repeat
	end repeat
end run
