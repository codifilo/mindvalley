# MindValley Channels
This project implements the MindValley app channels view which has three sections. New Episodes, Channels and Categories. All the data is loaded asynchronously from a JSON API calls and efficiently cached for offline use.


## Architecture

The general idea is that the application has a one single source of truth as an immutable state and the view implemented using SwiftUI and subscribes to update events for the app state using the Apple Combine library. The business logic is implemented in the interactors and the data access layer is implemented in the repositories. 

![alt text](https://github.com/nalexn/blob_files/blob/master/images/swiftui_arc_001_d.png?raw=true "Architecture Diagram")

Therefore the data flow is the view communicates to the interactor that is ready and then the interactor gets the parsed data from the web repository and places it on the app state, then the view receives the update event from the app state and displays the new data.

All dependencies are abstracted in protocols , encapsulated in a container and injected to the application on runtime.

The project architecture is based in the [Clean Architecture for SwiftUI post](https://nalexn.github.io/clean-architecture-swiftui/?utm_source=nalexn_github) written by Alexey Naumov.

## Project Structure
```
MindValley: Main source code folder
|
└───Repositories: Business logic that implements API calls JSON data retrieval and parsing
|
└───Models: All the models that represent the data parsed and downloaded from the API calls. 
|
└───Interactors: Business logics that connects the repositories, the app state and the UI
|
└───Injected: The container that encapsulates all the dependencies
|
└───System: The app system entry points that inject the dependencies to the rest of the app
|
└───UI: User interface layer 
|    |
|    └───Screens: It contains the only project UI screen
|    |
|    └───Components: All the UI reusable components that make up the screen.
|
└───Utilities: Diverse utilities and helpers
|
MindValleyTests: This folder contains all the unit tests
```
### Questions

- What parts of the test did you find challenging?
It went all very smoothly. I'm happy I used SwiftUI because it requires to write less code and simplifies things significantly. Setting up the constraints and the scroll views in UIKit would take at least an extra 50% effort.

- What feature would you like to add in the future to improve the project?
I would like to implement filtering by category and and the player view to actually start playing content.
