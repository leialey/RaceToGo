# Race To Go

## Overview

This app displays "Next to Go" races using a public API.
A user will see 5 races sorted by time ascending. Races disappear from the list after 1 minute past the start time.

## Architecture

The app uses MVVM (Model-View-ViewModel) and modular architecture. If needed, it can be easily split into several packages.

- **App.** The app itself, the main view model with all the dependencies that should be initialised once and passed around. Currently the only dependency that makes sense to initialise once is ApiService.

- **Extensions.** Reusable data type extensions, view modifiers and protocols.

- **Services.** Currently contain only Networking service and Error handling. For this app we could also add Logging, Analytics, but it's out of scope for this task. Networking service is split into Base ApiService and feature specific Racing API.

- **Models.** Data models used in the app - Model part of MVVM. Can be common and feature specific, currently there are only Racing feature specific data models.

- **Views.** This is the View-ViewModel part of MVVM. Views are split into Common and feature specific, currently there are only Racing feature specific data models. Common views also contain Base views which are used to hold common logic between all main views.

There are also a couple of extra folders in the project structure that haven't been made modular/feature specific, but could be if needed:

- **Resources.** This is app's assets such as images and colors, localizable string catalogs and Launch screen.

- **Preview Content.** Assets and preview specific files that will be stripped from the binary. Currently not being used.

## Frameworks
- SwiftUI
- Combine
- XCTest

## Features

### Business
#### Races
- "Next to Go".

### Mobile

#### Theme
- Light/dark mode

#### Accessibility
- Dynamic fonts
- Voice over

*(The list can go on with all the features enabled by default when creating a new Xcode project)*

## Testing
Unit tests have been implemented using the standard XCTest framework.

If an object can't be tested directly, a mock / partial mock is created in its place. Examples of such mocks are MockAPIService and mocked NextRacesResponse.

There is a base MockedDependenciesTestCase class to facilitate initialising all the mocked dependencies - specific test cases can inherit from it.

There is an easy way to create Data Model mocks when the data fetched from the backend be it for unit tests or SwiftUI previews:
1. Create a json file with the real payload. Wrap it into a "normal".
2. Conform data model to Mockable protocol.
For example, see NextRacesResponse data model.
