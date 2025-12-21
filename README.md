
# Tizi Fitness App

Tizi is a comprehensive fitness application built with Flutter that combines workout tracking, nutrition monitoring, professional fitness services, and e-commerce functionality. The app serves as a one-stop solution for fitness enthusiasts, offering features from workout planning to supplement shopping.

## Features

### Profile Dashboard
- Custom calendar widget for date selection and workout tracking
- Detailed nutrition tracking with visual representations
- Progress monitoring with weight gain/loss graphs
- Media gallery for progress photos and videos
- AI-powered assistant for personalized guidance
- Built-in music player for workout sessions

### Professional Services
- Subscribe to personal trainers
- Connect with nutritionists
- Gym membership management
- Professional consultation scheduling

### E-Commerce Integration
- Fitness supplement store
- Workout equipment shop
- Athletic wear marketplace
- Shopping cart functionality
- Order tracking (planned)

### Social & Media
- Progress photo/video gallery
- Social sharing capabilities
- Media upload functionality
- Progress tracking timeline

### Smart Features
- AI workout assistant
- Voice command support
- Photo and video capture
- Media library integration

## Technical Overview

### Frontend
- Built with Flutter/Dart
- Custom UI components
- Responsive design
- Material Design implementation
- Custom animations and transitions

### Planned Backend Integration
- Firebase Authentication
- Cloud Firestore for data storage
- Firebase Storage for media files
- Real-time database for chat features
- Firebase Analytics for usage tracking

### State Management
- Provider pattern implementation
- Efficient data flow
- Reactive state updates

## Current Status
- Frontend UI implementation complete
- Placeholder data for demonstration
- Ready for backend integration
- Core features implemented
- E-commerce framework in place

## Planned Features
- User authentication
- Real-time chat with professionals
- Payment gateway integration
- Order processing system
- User profile management
- Social features implementation
- Push notifications
- Workout video streaming
- Live session scheduling

## Navigation Structure
```
Bottom Navigation Bar
├── Profile/Dashboard
├── Media Gallery
├── Professional Services
│   ├── Trainers
│   ├── Nutritionists
│   └── Gyms
├── Shop
│   ├── Food & Supplements
│   ├── Clothes
│   └── Equipment
└── Cart
```

## UI Components
- Custom calendar widget
- Progress tracking graphs
- Nutrition donut charts
- Media gallery grid
- AI chat interface
- Music player
- Shopping cart system

## Data Models (Planned)
```dart
- User
- Trainer
- Nutritionist
- Gym
- Product
- Order
- Workout
- NutritionPlan
- Media
- Cart
```

## Installation

### Quick Start - Download APK

For Android users, you can download the pre-built APK:

1. Navigate to `build/app/outputs/flutter-apk/app-release.apk`
2. Transfer the APK to your Android device
3. Enable "Install from Unknown Sources" in your device settings
4. Install the APK (67.3MB)

### Build from Source

1. Clone the repository
```bash
git clone [repository-url]
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

4. Build APK (optional)
```bash
flutter build apk --release
```

## Build Information

### Latest Release APK
- **Location**: `build/app/outputs/flutter-apk/app-release.apk`
- **Size**: 67.3MB
- **Build Date**: December 21, 2025
- **Minimum SDK**: Android API 21+
- **Target SDK**: Android API 34

### Build Configuration
- **Flutter SDK**: 3.5.4+
- **Android Gradle Plugin**: 8.7.3
- **Kotlin**: 2.1.0
- **Java Compatibility**: 17
- **Code Minification**: Enabled (ProGuard/R8)

### Recent Build Fixes
The following issues were resolved to successfully build the APK:
1. Fixed typo in `android/build.gradle` - "dependancies" → "dependencies"
2. Updated Android Gradle Plugin from 7.3.0 to 8.7.3
3. Updated Kotlin version from 1.7.10 to 2.1.0
4. Updated Java compatibility from 1.8 to 17
5. Fixed Kotlin import syntax error in MainActivity.kt
6. Added missing Android permissions (INTERNET, LOCATION, etc.)
7. Created ProGuard rules for Stripe SDK compatibility
8. Fixed Google Services and Material Design library configurations

## Development Setup

### Prerequisites
- Flutter SDK (3.5.4 or higher)
- Dart SDK
- Android Studio/VS Code
- Firebase CLI (for backend integration)
- JDK 17 or higher

### Environment Setup
1. Create a Firebase project
2. Add Flutter application
3. Configure Firebase services
4. Set up environment variables

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## Project Structure
```
lib/
├── main.dart
├── presentation/
│   ├── pages/
│   └── widgets/
├── domain/
│   ├── models/
│   └── services/
├── data/
│   ├── repositories/
│   └── providers/
└── core/
    ├── constants/
    └── utils/
```

## Dependencies

### Core
- flutter_sdk
- firebase_core (3.8.0)
- firebase_auth (5.3.3)
- cloud_firestore (5.5.0)

### UI & Navigation
- curved_navigation_bar (1.0.6)
- fl_chart (0.55.0)
- flutter_feather_icons (2.0.0)
- line_icons (2.0.1)
- sliding_up_panel (2.0.0+1)

### Media & Camera
- image_picker (1.1.2)
- video_player (2.9.3)
- chewie (1.8.5)
- video_thumbnail (0.5.3)

### Location & Maps
- google_maps_flutter (2.1.1)
- geolocator (10.0.0)
- permission_handler (11.0.0)

### Payment & Commerce
- flutter_stripe (11.3.0)

### AI & APIs
- google_generative_ai (0.4.6)
- google_gemini (0.1.2)
- http (1.2.2)

### Data & Storage
- sqflite (2.3.0)
- sqflite_common_ffi (2.3.0)
- shared_preferences (2.1.0)
- path_provider (2.1.5)
- path (1.9.0)

### Utilities
- intl (0.17.0)
- random_string (2.3.1)
- cupertino_icons (1.0.8)

## Notes
- Authentication is done
- Currently using placeholder data
- Backend integration pending
- E-commerce features in development
- Media handling to be implemented

## Future Roadmap
1. Implement Firebase backend
2. Integrate payment gateway
3. Develop order processing
4. Add real-time chat
5. Implement push notifications
6. Add video streaming
7. Develop social features

## License
This project is licensed under the MIT License - see the LICENSE file for details

## Contact
For any queries regarding this project, please contact [contact information]