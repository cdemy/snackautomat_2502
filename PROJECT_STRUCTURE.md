
# My Recomendation for your Snackautomat Filestructure
## `lib` Directory Structure

```
lib/
├── app.dart
├── main.dart
├── models/
├── domain/
│   ├── providers/
│   └── state/
├── screens/
│   └── main/
│       └── _widgets/
└── shared/
    ├── widgets/
    └── constants/
```

If an API would be added later i would recommend to implement an core structure.
Given that there is only "one feature" we could dispense with a feature folder and simply use a flat architecture. However, this approach has its limitations when the application grows beyond a single feature.


# Project Structure with feature-first directory structure

This document outlines the feature-first directory structure for the Flutter application. This structure is designed to be scalable, maintainable, and promote a clear separation of concerns.

## `lib` Directory Structure

```
lib/
├── app.dart
├── main.dart
├── core/
│   ├── services/
│   └── utils/
├── features/
│   └── vending_machine/
│       ├── data/
│       │   └── models/
│       ├── domain/
│       │   ├── providers/
│       │   └── state/
│       └── presentation/
│           ├── screens/
│           └── widgets/
└── shared/
    ├── widgets/
    └── constants/
```

---

## Rationale for the Structure

### Top-Level Files

*   **`main.dart`**: The main entry point of the application. Its role is minimal: to initialize the app and run it.
*   **`app.dart`**: The root widget of the application (`MyApp`). It contains the `MaterialApp`, theme data, and any other top-level configurations or providers that should be available to the entire app.

### Core

The `core/` directory contains code that is fundamental to the application but is not a feature itself. This code is often related to infrastructure and cross-cutting concerns.

*   **`services/`**: For cross-feature services, such as API clients, database handlers, authentication services, or device-level services (e.g., location, permissions).
*   **`utils/`**: Contains utility functions, helper classes, and extensions that can be used throughout the application.

### Features

The `features/` directory is the heart of the application. Each subdirectory represents a self-contained feature, encapsulating all the code related to that feature.

*   **`vending_machine/`**: An example of a feature directory. It contains all the logic, UI, and data models for the vending machine functionality.
    *   **`data/`**: The data layer, responsible for data models and data sources.
        *   `models/`: Contains the data models (e.g., `Snack`, `Product`).
    *   **`domain/`**: The business logic layer. It is independent of the UI and data sources.
        *   `providers/`: Riverpod providers that manage the state and business logic for this feature.
        *   `state/`: The state classes (e.g., `AppState`, `AppStateNotifier`).
    *   **`presentation/`**: The UI layer, which is responsible for displaying data and handling user input.
        *   `screens/`: The main screen for the feature.
        *   `widgets/`: All widgets that are specific to this feature's screen(s).

### Shared

The `shared/` directory contains code that is reused across multiple features but is not part of the application's core infrastructure.

*   **`widgets/`**: Common, reusable UI components like custom buttons, styled text fields, or loading indicators.
*   **`constants/`**: Application-wide constants, such as API keys, route names, or color palettes.

---

## Benefits of this Structure

*   **Scalability**: Adding a new feature is as simple as creating a new directory under `features/`. This keeps the project organized as it grows.
*   **Modularity**: Each feature is self-contained, making it easier to develop, test, and maintain in isolation.
*   **Maintainability**: When working on a feature, all the relevant files are located in one place, which reduces the need to navigate across the entire project.
*   **Clear Separation of Concerns**: The structure enforces a clean separation between the data, domain (business logic), and presentation (UI) layers within each feature.
