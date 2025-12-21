
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
2. Download the APK (67.3MB)
3. Transfer the APK to your Android device
4. Enable "Install from Unknown Sources" in your device settings
5. Install and enjoy!

**Build Information:**
- APK Size: 67.3MB
- Build Type: Release (Optimized)
- Min SDK: Android API 21+
- Target SDK: Android API 34
- Built with: Flutter 3.5.4, Kotlin 2.1.0, AGP 8.7.3

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

## Development Setup

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio/VS Code
- Firebase CLI (for backend integration)

### Environment Setup
1. Create a Firebase project
2. Add Flutter application
3. Configure Firebase services
4. Set up environment variables

## Build Notes

The production APK has been successfully built with the following fixes applied:

### Configuration Fixes
1. **Gradle Configuration**
   - Fixed typo: `dependancies` → `dependencies`
   - Updated Android Gradle Plugin: 7.3.0 → 8.7.3
   - Updated Kotlin version: 1.7.10 → 2.1.0
   - Updated Java compatibility: 1.8 → 17

2. **Android Manifest**
   - Added required permissions: INTERNET, LOCATION, CAMERA, STORAGE, NETWORK_STATE, WAKE_LOCK

3. **MainActivity.kt**
   - Fixed import syntax error in Kotlin file

4. **ProGuard Configuration**
   - Created proguard-rules.pro with Stripe SDK rules
   - Configured code minification for release builds

5. **Dependencies**
   - Fixed package references and version placeholders
   - Updated Material Design library to 1.9.0
   - Configured Firebase BOM to 33.6.0

### Build Output
- Location: `build/app/outputs/flutter-apk/app-release.apk`
- Size: 67.3MB (optimized with R8/ProGuard)
- Includes all dependencies and assets

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
- flutter_sdk
- firebase_core
- cloud_firestore
- firebase_auth
- provider
- intl
- image_picker
- url_launcher
- shared_preferences

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