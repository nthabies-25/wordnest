# WordNest

**Discover, generate, and save creative word combinations.**

WordNest is a Flutter application built with Dart that generates random English word pairs and allows users to save their favourites.

This project was developed as a hands-on introduction to Flutter, focusing on widget development, state management, user interaction, and navigation.

## Features

- **Random Word Generation:** Generate new English word combinations with the Next button.
- **Save Favourites:** Like interesting word combinations and save them to a favourites list.
- **Manage Favourites:** Remove previously saved words from the list.
- **Page Navigation:** Switch between the word generator and favourites pages.
- **Responsive Layout:** Navigation adjusts to the available screen width.
- **Material Design:** A clean interface using Flutter's Material Design components.

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform UI development |
| Dart | Programming language |
| Provider | Application state management |
| english_words | Random English word generation |
| Material Design | User interface components |

## How It Works

1. Launch WordNest to see a randomly generated word combination.
2. Click **Next** to generate another word pair.
3. Click **Like** to add the current word pair to your favourites.
4. Navigate to **Favorites** to view your saved words.
5. Remove words from your favourites when they are no longer needed.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK (included with Flutter)
- VS Code or Android Studio
- Chrome or another supported Flutter development target

### Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/wordnest.git
```

Navigate to the project:

```bash
cd wordnest
```

Install dependencies:

```bash
flutter pub get
```

Run the application in Chrome:

```bash
flutter run -d chrome
```

## Testing

Run the widget tests:

```bash
flutter test
```

Check the code for static analysis issues:

```bash
flutter analyze
```

## Future Improvements

- Dark mode support
- Animated word transitions
- Search and filter saved favourites
- Persistent storage so favourites remain saved after restarting the app
- Additional UI customisation

## Project Purpose

WordNest is a learning project demonstrating practical Flutter development skills, including:

- Stateless and Stateful widgets
- State management using `ChangeNotifier` and Provider
- Widget composition and reusable components
- Navigation with `NavigationRail`
- Responsive layouts using `LayoutBuilder`
- Widget testing

## Author

Developed as part of my Flutter and Dart learning journey.
