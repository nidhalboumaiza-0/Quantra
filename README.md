# Quantra Weather

A mobile weather application with location-aware forecasts, maps, profiles, and notifications. The Flutter client is paired with a Node.js service for accounts and notification-related endpoints.

## Features

- Current weather and forecast views
- Device location and map integration
- User profile and settings
- Push-notification support
- Authentication and notification API

## Tech Stack

- Flutter and Dart
- BLoC state management
- Geolocator and Google Maps
- Firebase and OneSignal integrations
- Node.js, Express, and MongoDB

## Structure

```text
client/   Flutter mobile application
server/   Express API
```

## Run Locally

```bash
cd server
npm install
npm start
```

```bash
cd client
flutter pub get
flutter run
```

Provide weather, maps, notification, and backend configuration through local environment values. Existing development keys should be rotated before publishing or deploying the application.
