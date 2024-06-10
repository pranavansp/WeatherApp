# WeatherApp

Documentation for Project WeatherApp. 

## Installation

1. Clone the repository (branch: main) or download the project.
2. Open the WeatherApp.xcodeproj Xcode 15 or above project file.
3. Build and run the project on either a simulator or a device.

## Usage

To run the project, open it on either a simulator or a physical device. Once the project loads, you will see an 'Ask for permission' prompt to allow the app to determine your current location for retrieving the current weather. Tap the 'Search city and airport' button to search for a location and update the weather for a custom location.

If the network and server are functioning correctly, the results will be displayed on the screen under each section corresponding to the request.

## Architecture

This project utilizes the MVVM architecture, leveraging Swift and Combine technologies. No dependency manager was used, as it was unnecessary for completing this task. Additionally, a routing pattern has been implemented.

Please refer to the following section for details on the selection and usage of the optimized algorithm. 

## Design decisions. 

1. Selected closures over delegates to communicate from the second screen to the first because closures provide a lighter and more flexible alternative for callbacks and event handling, promoting loose coupling.

2. Created ViewModel protocols to enhance dependency injection, promote loose coupling, enable the creation of mock-based SwiftUI views, and support encapsulation. (ex: Protocol: ViewModel, Implmentation: DefaultViewModel, Mock/Preview: MockViewModel)

3. The Network Utility and Location Manager have been injected into the view model as dependencies, enabling the writing of unit tests and mock-based unit tests for view models.

4. For location fetch, data is loaded from the origin only if there is no cache, utilizing URLRequest cachePolicy. However, for current weather data, since it's subject to frequent changes, a proper mechanism for cache management was deemed necessary. Cache revalidation is not supported by the origin.

## Unit testing.

1. The DefaultLandingViewModelTests unit tests have been comprehensively covered with mock API testing.
2. The WeatherAppRouterTests unit tests have been comprehensively covered.

## TBD

1. Implement cache revalidation once it is supported by the origin. (openweathermap.org)
2. Implement unit testing for DefaultSearchViewModel same as DefaultLandingViewModelTests
3. Implement UI testing.
 
## Thank you for taking your time to review this project! 😊
