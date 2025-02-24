# **To-Do App** 📝  

A simple To-Do app built with **Flutter** using **BLoC State Management** and **SharedPreferences** for local storage.  

## **📌 Features**  
✅ Display a list of tasks  
✅ Add new tasks  
✅ Mark tasks as completed  
✅ Delete tasks  
✅ Persist tasks using **SharedPreferences**  



## **🛠️ Tech Stack**  
- **Flutter** (Dart)  
- **Flutter BLoC** (State Management)  
- **SharedPreferences** (Local Storage)  

## **🚀 Getting Started**  

### **Prerequisites**  
Ensure you have **Flutter** installed. Check by running:  
```sh
flutter --version
```

### **Installation**  
1. Clone the repository:  
   ```sh
   git clone https://github.com/your-username/todo-app.git
   cd todo-app
   ```

2. Install dependencies:  
   ```sh
   flutter pub get
   ```

3. Run the app:  
   ```sh
   flutter run
   ```

## **📂 Project Structure**  

```
📦 todo_app
 ┣ 📂 lib
 ┃ ┣ 📂 bloc          # BLoC state management
 ┃ ┃ ┗ task_bloc.dart
 ┃ ┣ 📂 model         # Task model
 ┃ ┃ ┗ task.dart
 ┃ ┣ 📂 screens       # UI screens
 ┃ ┃ ┗ task_screen.dart
 ┃ ┣ main.dart        # Entry point
 ┃ ┗ ...
 ┣ 📂 android         # Android-specific files
 ┣ 📂 ios             # iOS-specific files
 ┣ pubspec.yaml       # Dependencies
 ┗ README.md          # Project Documentation
```

## **📌 How It Works**  

- The app uses **BLoC (Business Logic Component)** for state management.  
- Tasks are stored locally using **SharedPreferences**.  
- The UI updates dynamically based on the task list.  

## **🔧 Troubleshooting**  
If you face issues, try:  
```sh
flutter clean
flutter pub get
flutter run
```

## **📜 License**  
This project is **open-source**. Feel free to use and modify it.  

---
