# airdrop-cli

A command line interface for AirDrop

## Xcode Integration

In order to use this tool with the [Swift Playgrounds Author Template](https://developer.apple.com/download/more/?=Swift%20Playgrounds%20Author%20Template), add `airdrop.applescript` to your project's `SupportingContent/Tools/` directory and then create a new External Build Tool target named "Install".

Set the following configuration in **Info**:

- Build Tool: `$(SRCROOT)/SupportingContent/Tools/airdrop.applescript`
- Arguments: `"$(TARGET_BUILD_DIR)/$(PLAYGROUND_BOOK_FILE_NAME).playgroundbook" "ICLOUD_NAME" "iPad"` (replace `ICLOUD_NAME` with your iCloud name)
- Directory: None (leave empty)
- Pass build settings in environment: yes

Next, go to **Build Phases** and add the `PlaygroundBook` target to the Target Dependencies phase.

When you wish to install the Playground Book onto your device, simply select the "Install" target and either click the Run button or use CMD+B.
