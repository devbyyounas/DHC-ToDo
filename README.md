📝 Flutter Todo App
A simple Todo Application built with Flutter that allows users to manage daily tasks efficiently.
The app includes a splash screen, a basic login screen, and a task management screen with local data persistence.
# Features
Splash screen with app title "Todo App"
Basic login screen (UI navigation)
Task management functionality:
Add new tasks
Update existing tasks
Delete tasks (swipe to delete)
Local data storage using SharedPreferences
Simple and clean user interface
# App Flow
App starts with a Splash Screen
Automatically navigates to the Login Screen
After login, user is taken to the Todo Screen
User can manage tasks (add, update, delete)
#  Technologies Used
Flutter
Dart
SharedPreferences (for local storage)
# Project Structure
lib/
├── screens/
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   └── todo_screen.dart
├── main.dart
# Getting Started
1. Clone the Repository
git clone https://github.com/your-username/flutter-todo-app.git
2. Navigate to the Project
cd flutter-todo-app
3. Install Dependencies
flutter pub get
4. Run the App
flutter run
# Functionality Overview
Task Management
Tasks are stored locally using SharedPreferences
Users can:
Add a task
Edit a task
Delete a task using swipe gesture
Data Persistence
Tasks remain saved even after closing the app
# Future Improvements
Proper authentication system
Improved UI/UX design
Cloud storage integration
Task categories or priorities
# License
This project is open-source and available under the MIT License.
# Author
Muhammad Younas