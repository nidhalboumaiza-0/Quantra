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

1. Install Node.js 18 or newer, Flutter, and MongoDB. Start MongoDB locally or prepare an Atlas connection.
2. Open a terminal in `server/`, install dependencies, and create `server/.env`:

   ```bash
   cd server
   npm install
   ```

   ```dotenv
   NODE_ENV=development
   PORT=3000
   DATABASE=mongodb://127.0.0.1:27017/quantra
   JWT_SECRET=replace-with-a-long-random-value
   JWT_EXPIRE_IN=1d
   REFRESH_TOKEN_SECRET=replace-with-another-long-random-value
   REFRESH_TOKEN_EXPIRE_IN=30d
   EMAIL_USER=your-development-email
   EMAIL_PASSWORD=your-email-app-password
   ```

3. Start the backend:

   ```bash
   npm start
   ```

4. Create or update `client/.env`. For an Android emulator, use:

   ```dotenv
   URL=http://10.0.2.2:3000/api/v1
   URLIMAGE=http://10.0.2.2:3000/images/
   ```

5. Replace the development weather API key in `client/lib/data/my_data.dart` with your own key. Configure your own Google Maps, Firebase, and OneSignal projects for the corresponding features.
6. Open another terminal, prepare Flutter, and select a device:

   ```bash
   cd client
   flutter pub get
   flutter devices
   ```

7. Run the mobile application:

   ```bash
   flutter run
   ```

Use `localhost` for desktop or the computer's LAN IP for a physical phone. Rotate any old development keys before publishing or deploying the application.
