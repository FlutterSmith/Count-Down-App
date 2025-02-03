# ⏳ Countdown App

📌 **Version:** 1.0.0  
📅 **Last Updated:** 2, 2025
👤 **Author:** Ahmed Hamdy 
🔗 **Repository:** https://github.com/FlutterSmith/Count-Down-App/

---

## 📖 Overview

**Countdown App** is a feature‑rich application built with **Flutter** that enables users to create and manage countdown events. Whether it’s a wedding, birthday, or any important event, the app displays a live countdown (days, hours, minutes, and seconds) until the event occurs. The app leverages **Provider** for state management, uses **sqflite** for local persistence, and schedules push notifications to remind users as the event approaches. Additionally, the app supports customization options like color schemes, emojis, and background images.

✅ **Create & Manage Countdown Events**  
✅ **Live Countdown Timer Display**  
✅ **Local Data Persistence with SQLite**  
✅ **Push Notifications for Event Reminders**  
✅ **Customizable Event Appearance**

![Countdown App Demo](https://media.giphy.com/media/abk1YrVJlxcuA/giphy.gif?cid=ecf05e473iaz0hacpmhgio52qoynn2p0i0mvaoyc1wx1dis9&ep=v1_gifs_search&rid=giphy.gif&ct=g)

---

## 🚀 Features

### 📅 Event Management
✔ **Add New Countdown Events:** Input an event name, select a date and time, and set notification preferences.  
✔ **View Active Events:** A dedicated screen lists all upcoming events with their respective countdown timers.  
✔ **Archive Past Events:** Automatically archives events once the event date has passed.

### ⏰ Live Countdown Display
✔ **Real-Time Timer:** The countdown screen updates every second, showing days, hours, minutes, and seconds remaining.

### 🔔 Push Notifications
✔ **Scheduled Reminders:** Notifications are scheduled to alert users a specified number of days before an event occurs.

### 🎨 Customization
✔ **Event Customization:** Users can select custom color schemes, assign emojis, or even choose background images for each event.

### 🗄️ Local Persistence
✔ **SQLite Database:** All event data is stored locally using **sqflite**. For desktop support, **sqflite_common_ffi** is used to initialize the database factory.

### 🔄 State Management
✔ **Provider Pattern:** The app uses the **Provider** package for efficient state management and seamless data sharing between screens.

---

## 🛠️ Tech Stack

| Technology                   | Purpose                                                     |
|------------------------------|-------------------------------------------------------------|
| **Flutter**                  | Cross‑platform mobile app development                       |
| **Dart**                     | Primary programming language                                |
| **Provider**                 | State management                                            |
| **sqflite**                  | Local SQLite database integration                           |
| **sqflite_common_ffi**       | Desktop support for SQLite via FFI                          |
| **flutter_local_notifications** | Scheduling and managing push notifications            |
| **Image Picker**             | Optional: Custom background image selection                |

---

## 🚀 Installation

### 📌 Prerequisites
- ✅ **Flutter SDK** (Latest stable version)  
- ✅ **Dart SDK** (Bundled with Flutter)  
- ✅ **Android Studio / VS Code** (With Flutter extensions)

### 📦 Steps to Run

1️⃣ **Clone the Repository**  
    ```
      git clone https://github.com/yourusername/countdown_app.git
    cd countdown_app```
2️⃣ Install Dependencies
```
flutter pub get
```

3️⃣ Run the App
For mobile:
```
flutter run
```

For desktop (Windows, Linux, macOS):
```
flutter run -d windows   # or -d linux, -d macos as applicable
```
📌 Future Improvements
✅ Additional Event Categories & Tags
✅ Advanced Customization Options (Fonts, Animations)
✅ Cloud Backup & Synchronization
✅ Cross-Platform Widgets (Android Home-Screen Widget, etc.)
✅ Localization for Multiple Languages

🏆 Contributors
👤 Ahmed Hamdy
GitHub: FlutterSmith

📝 License
This project is licensed under the MIT License. See the LICENSE file for details.

📢 Acknowledgments
If you find Countdown App helpful or exciting, please consider 🌟 starring the repository and contributing to its ongoing development. Enjoy managing your special events with ease!

