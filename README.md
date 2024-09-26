# Chat Application

- This Chat Application is a Flutter app designed for real-time messaging, 
- allowing users to connect, send messages, and manage their chat sessions. 
- The app integrates with Firebase Auth for authentication and Firestore for real-time message storage and retrieval.


# Features
- User Authentication: Sign up and log in using Firebase Authentication.
- Real-time Messaging: Send and receive messages instantly, with updates handled via StreamBuilder from Firestore.
- Chat Rooms: Join or create chat rooms and interact with multiple users.
- Message History: Retrieve and display past conversations stored in Firestore.
- Responsive UI: A clean and adaptable UI for various screen sizes.


# Technologies Used
- Flutter: Framework for building the cross-platform mobile application.
- Firebase Auth: For handling user authentication and login.
- Firestore: Real-time NoSQL database for storing and retrieving chat data.
- Provider: State management for efficient data handling.
- StreamBuilder: To listen for real-time Firestore updates and display live chat messages.
- Dart: The programming language used for Flutter.

# Installation
- Clone the Repository

- git clone https://github.com/oso020/Chat-APP-ROUTE.git
- Navigate to the Project Directory

# cd Chat-APP-ROUTE
# Install Dependencies

Run the following command to fetch the required packages:


# flutter pub get
# Firebase Setup

- Create a Firebase project in the Firebase Console.
- Download the required configuration files and add them to your Flutter project as per the Firebase setup guide.
- Run the Application

To run the application on your preferred device, use:


#  flutter run


Memory updated
Here’s an outline tailored for your chat app project using the MVVM design pattern with Firebase Auth, Firestore, Provider for state management, and StreamBuilder for real-time Firestore updates:

Chat Application
This Chat Application is a Flutter app designed for real-time messaging, allowing users to connect, send messages, and manage their chat sessions. The app integrates with Firebase Auth for authentication and Firestore for real-time message storage and retrieval.

# Features
- User Authentication: Sign up and log in using Firebase Authentication.
- Real-time Messaging: Send and receive messages instantly, with updates handled via StreamBuilder from Firestore.
- Chat Rooms: Join or create chat rooms and interact with multiple users.
- Message History: Retrieve and display past conversations stored in Firestore.
- Responsive UI: A clean and adaptable UI for various screen sizes.

#Technologies Used
- Flutter: Framework for building the cross-platform mobile application.
- Firebase Auth: For handling user authentication and login.
- Firestore: Real-time NoSQL database for storing and retrieving chat data.
- Provider: State management for efficient data handling.
- StreamBuilder: To listen for real-time Firestore updates and display live chat messages.
- Dart: The programming language used for Flutter.

#Getting Started
- Prerequisites
- Flutter (version 3.0 or later)
- Dart
- Firebase Project Setup
- Firebase configuration files (google-services.json for Android, GoogleService-Info.plist for iOS)
- Installation
- Clone the Repository





# Architecture Overview (MVVM)
- The app follows the MVVM (Model-View-ViewModel) design pattern, ensuring a clean separation of concerns:

- Model: Represents the chat message and user data fetched from Firestore.
- View: The Flutter UI screens, including chat rooms, login, and registration views.
- ViewModel: Interacts with Firebase and Firestore, manages state with Provider, and exposes data to the views.
- Firestore Structure
- The Firestore database is organized as follows:

# Users Collection:
- Fields: username, email.
- ChatRooms Collection:
- Each document represents a chat room.
- Fields: roomName, createdBy, timestamp, etc.
- Subcollection: Messages
- Fields: messageText, sentBy, timestamp, etc.





## Screenshots

<p align="center">
  <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/spalsh.png" alt="chat" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/login.png" alt="chat" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/register.png" alt="chat" width="220" style="margin: 10px;"/>
</p>

<p align="center">
    <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/home.jfif" alt="chat" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/create%20room.png" alt="chat" width="220" style="margin: 10px;"/>
  <img src="https://github.com/oso020/Chat-APP-ROUTE/blob/develop/screen_shots/chat%20screen.png" alt="chat" width="220" style="margin: 10px;"/>
</p>

# License
- This project is licensed under the MIT License - see the LICENSE file for details.

- You can modify the structure and code snippets to suit your specific app's needs. Let me know if you need more detailed implementations for any section!



