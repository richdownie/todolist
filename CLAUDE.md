# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

This is a SwiftUI iOS application built with Xcode. Use the following commands for development:

### Building and Running
- `xcodebuild -project todolist.xcodeproj -scheme todolist -destination 'platform=iOS Simulator,name=iPhone 15' build` - Build the app for iOS Simulator
- `xcodebuild -project todolist.xcodeproj -scheme todolist -destination 'platform=iOS Simulator,name=iPhone 15' build-for-testing` - Build for testing
- Open in Xcode: `open todolist.xcodeproj` - Launch Xcode IDE

### Testing
- `xcodebuild test -project todolist.xcodeproj -scheme todolist -destination 'platform=iOS Simulator,name=iPhone 15'` - Run all tests
- `xcodebuild test -project todolist.xcodeproj -scheme todolist -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:todolistTests` - Run unit tests only
- `xcodebuild test -project todolist.xcodeproj -scheme todolist -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:todolistUITests` - Run UI tests only

## Project Architecture

This is a multi-platform SwiftUI application with the following structure:

### Targets
- **todolist**: Main app target (iOS, macOS, visionOS)
- **todolistTests**: Unit tests using Swift Testing framework
- **todolistUITests**: UI tests using XCTest framework

### Key Files
- `todolist/todolistApp.swift`: App entry point with @main struct
- `todolist/ContentView.swift`: Main SwiftUI view (currently displays "Hello, world!")
- `todolist/Assets.xcassets/`: App icons and color assets

### Platform Support
The app is configured to support:
- iOS 18.0+ (iPhone/iPad)
- macOS 15.6+
- visionOS 2.0+

### Build Configuration
- Uses automatic code signing
- App Sandbox enabled
- SwiftUI Previews enabled
- Modern Swift concurrency features enabled (MainActor isolation)
- Swift 5.0 with upcoming language features