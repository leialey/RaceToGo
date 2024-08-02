# Race To Go

## Overview

This app displays "Next to Go" races using a public API.
A user will see 5 races sorted by time ascending. Races disappear from the list after 1 minute past the start time.

## Architecture

The app uses MVVM - Model-View-ViewModel. Its structure is modular, and if needed, it can be easily split into several packages.

- **App.** The app itself, the main view model with all the dependencies that should be initialised once and passed around. Currently the only dependency that makes sense to initialise once is ApiService.

- **Extensions.** Reusable data type extensions, view modifiers and protocols.

- **Services.** Currently consist of Networking service and Error handling. For this app we could also add more: e.g. Logging, Analytics, but it's out of scope for this task. Networking service is split into base ApiService and feature specific Racing API.

- **Models.** Data models used in the app - Model part of MVVM. Can be common and feature specific, currently there are only Racing feature specific data models.

- **Views.** This is the View-ViewModel part of MVVM. Views are split into common and feature specific, currently there are only Racing feature specific data models. Common views also contain Base views and view models which hold common logic between all main views, e.g. presenting alerts.

There are also a couple of extra folders in the project structure that haven't been made modular/feature specific, but could be if needed:

- **Resources.** This is app's assets such as images and colors, localizable string catalogs and Launch screen.

- **Preview Content.** Assets and preview specific files that will be stripped from the binary during archiving. Currently not being used.

## Frameworks
- Foundation
- SwiftUI
- Combine
- XCTest

## Code styling
Code style follows default rules used by SwiftLint, which are generally accepted by the Swift community.

MARKs are used throughout the code for easier navigation, splitting files into logical parts such as Variables, Dependencies, Init, Public methods etc.


## Features
### Business
#### Races
- **Next to Go.** A user should always see 5 races, and they should be sorted by time ascending. Race should disappear from the list after 1 minute past the start time.

### Mobile
#### Theme
- Light/dark mode

#### Accessibility
- Dynamic type
- Bold text
- Voice over

#### Localizations
- English (US)

*(The list can go on with all the features enabled by default when creating a new Xcode project such as portrait/landscape etc)*

## Testing
### Unit tests
Unit tests have been implemented using the standard XCTest framework.
RaceToGoTests folder structure attempts to mimic the main RaceToGo project structure for easier navigation.

If an object can't be tested directly, a mock / partial mock is created in its place. Examples of such mocks are MockAPIService and mocked NextRacesResponse.

There is a base MockedDependenciesTestCase class to facilitate initialising all the mocked dependencies - specific test cases can inherit from it.

There is an easy way to create Data Model mocks when the data is fetched from the backend. They can be used for both unit tests and SwiftUI previews.
1. Create a json file with the real payload. Wrap it in the value for key "normal" - this is the default mock name.
2. Conform data model to Mockable protocol.
3. Call either Type.mock() to get its Data object or mockDecoded to get its Type object.
To better understand how to use Mockable, see NextRacesResponse.

### UI tests
There are 2 default UI tests that were created automatically when creating Xcode project.
