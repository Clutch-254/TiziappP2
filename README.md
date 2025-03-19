# Tizi Fitness App - Flutter Project

## Overview

This Flutter project is a fitness-related application designed to help users explore and purchase food, supplements, gym equipment, workout outfits, and connect with trainers, nutritionists, and gyms. The app is divided into three main sections:

1. **Food & Supplements**: Users can browse and purchase food items and supplements.
2. **Gym Accessories**: Users can explore gym equipment and workout outfits.
3. **Homepage**: Users can connect with trainers, nutritionists, and gyms.

The app is built using Flutter and follows a modular structure for easy maintenance and scalability.

---

## Features

### 1. **Food & Supplements**
   - Toggle between **Foods** and **Supplements**.
   - Display a horizontal scrollable list of items with images, titles, and prices.
   - Navigate to product details (partially implemented).

### 2. **Gym Accessories**
   - Toggle between **Equipment** and **Gym Outfits**.
   - Display a horizontal scrollable list of items with images, titles, and prices.
   - Floating action button for quick scrolling to the bottom of the page.

### 3. **Homepage**
   - Toggle between **Trainers**, **Nutritionists**, and **Gyms**.
   - Display a horizontal scrollable list of items with images, titles, descriptions, and prices.

---

## Incomplete Features

The following features are currently incomplete and require further development:

1. **Profile Page**:
   - A profile page for users to view and edit their personal information, preferences, and order history is missing.

2. **Navigation**:
   - Navigation to the `Productdetails` page is partially implemented. Data is not passed to the `Productdetails` page when navigating.

3. **Database Integration**:
   - The `DatabaseMethods` class is referenced but not fully utilized. Streams like `gymItemStream`, `fitItemStream`, and `subItemStream` are fetched but not displayed in the UI.

4. **Error Handling**:
   - No error handling is implemented for cases where database fetch operations fail or return null.

5. **UI Enhancements**:
   - Additional features like search, filtering, sorting, and a shopping cart system are missing.

---

## Project Structure

The project is organized into the following directories:

- **`lib/`**: Contains the main application code.
  - **`presentation/`**: Contains the UI widgets and pages.
    - `foodnsupplements.dart`: Widget for food and supplements section.
    - `gymaccessories.dart`: Widget for gym accessories section.
    - `homepage.dart`: Widget for the homepage.
    - `productdetails.dart`: Widget for product details (incomplete).
  - **`technicals/`**: Contains backend and utility code.
    - **`widgets/`**:
      - `database.dart`: Handles database operations (incomplete).
      - `supportwidget.dart`: Contains reusable widgets and styles.

---

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- Dart SDK (included with Flutter).
- An IDE like Android Studio or VS Code with Flutter and Dart plugins installed.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/fitness-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd fitness-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## Future Work

The following tasks are recommended to complete the project:

1. **Implement the Profile Page**:
   - Create a new widget for the profile page.
   - Include fields for user information, preferences, and order history.
   - Add functionality to edit and save user data.

2. **Complete Navigation**:
   - Pass relevant data (e.g., item details) to the `Productdetails` page when navigating.
   - Ensure the `Productdetails` page displays the passed data correctly.

3. **Integrate Database Streams**:
   - Use the fetched streams (`gymItemStream`, `fitItemStream`, `subItemStream`) to dynamically populate the UI.
   - Add error handling for cases where the streams fail or return null.

4. **Add Error Handling**:
   - Implement error handling for database fetch operations.
   - Display appropriate error messages to the user if something goes wrong.

5. **Enhance UI**:
   - Add search, filtering, and sorting functionality.
   - Implement a shopping cart system for users to add items before checkout.

6. **Consider State Management**:
   - If the application grows in complexity, consider using a state management solution like **Provider** or **Riverpod** to manage the application state more efficiently.

---

## Example of a Profile Page Implementation

Here’s a basic example of how the profile page could be implemented:

```dart
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile logic here
              },
              child: Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes.
4. Push your branch and submit a pull request.

---

## License

This project is licensed under the MIT License. 

---

## Contact

For any questions or suggestions, feel free to reach out:

- **Email**: your-email@example.com
- **GitHub**:Clutch-254(https://github.Clutch-254)

---

Thank you for checking out this project! 🚀
