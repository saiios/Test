# Random Cat Facts and Images App

**Overview**

This SwiftUI app showcases a random cat image and a fun cat fact upon opening. Users can refresh the content by tapping anywhere on the screen or using the pull-to-refresh gesture. The app is designed with a clean and scalable architecture (MVVM), ensuring proper separation of concerns, testability, and maintainability.



**Features**

**Random Cat Image**: Fetches a random cat image from the Cat API.

**Random Cat Fact**: Fetches a random cat fact from the Meow Facts API.

**Tap to Refresh**: Users can tap anywhere on the screen to fetch new data.

**Pull-to-Refresh**: Users can use a pull-to-refresh gesture to reload data.

**Animations**: Smooth transitions for image updates using SwiftUI's animation capabilities.

**Error Handling**: Displays user-friendly messages in case of API errors.

**Offline Mode**: Caches the last fetched image and fact for offline access (optional bonus feature).

**Third-Party Integration**: Utilizes Kingfisher for efficient image downloading and caching.

**Dark Model Support**: App will works for both light & dark mode.

**Unit and UI Tests**: Comprehensive tests for 100% code coverage.



**Architecture**

The app follows the MVVM (Model-View-ViewModel) architecture to ensure:

**Separation of Concerns**: UI logic is separated from business logic.

**Testability**: ViewModels are decoupled from Views, making unit testing more straightforward.

**Scalability**: Easily extendable to accommodate new features.



**Tech Stack**

**Language**: Swift

**Frameworks**:

SwiftUI for UI design.

Combine for asynchronous programming.

Kingfisher for image downloading and caching.



**Testing Tools**:

XCTest for Unit and UI Tests.

Mocking with Combine for simulating network responses.

How to Run the Project

**Clone** the repository:
  git clone https://github.com/saiios/test.git
  
cd random-cat-facts

Open the project in Xcode:

open RandomCatFacts.xcodeproj



**Install dependencies:**

Ensure Swift Package Manager (SPM) is enabled in Xcode.

Kingfisher will automatically download and integrate.

Build and run the project on a simulator or device.



**API References**

Random Cat Fact: Meow Facts API

Random Cat Image: The Cat API



**Testing**

**Unit Tests**
Coverage: 100% for all ViewModel and Network layers.

Verifies the correctness of API calls, data parsing, and state management.

**UI Tests**

Automated tests for:

Verifying the correct display of cat facts and images.

Ensuring seamless user interactions (tap-to-refresh and pull-to-refresh).

Validating error handling UI states.



**To run the tests:**

Open the Test Navigator in Xcode.

Run all Unit and UI test cases.

![Simulator Screenshot - iPhone 16 Pro - 2024-12-07 at 21 13 37](https://github.com/user-attachments/assets/c58a76ba-e8ce-4fdb-8bfd-8c35e919c64d)

![Simulator Screenshot - iPhone 16 Pro - 2024-12-07 at 21 16 19](https://github.com/user-attachments/assets/baafc17f-fd18-4a40-a6fa-37936adeeb23)

