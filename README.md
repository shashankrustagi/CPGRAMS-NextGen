# CPGRAMS NextGen ��

> A modern, AI-powered grievance redressal mobile application built with Flutter, inspired by India's CPGRAMS system.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## 📱 About

**CPGRAMS NextGen** is a next-generation grievance redressal system designed to modernize how citizens file and track complaints with government departments. Built with Flutter for cross-platform compatibility, this app addresses the pain points of existing systems with a clean, intuitive interface and modern features.

### 🎯 Problem Statement

Current government grievance portals suffer from:
- ❌ Complex, outdated interfaces
- ❌ Poor mobile experience
- ❌ Lack of real-time tracking
- ❌ No AI-assisted categorization
- ❌ Limited accessibility features

### ✨ Our Solution

CPGRAMS NextGen provides:
- ✅ Clean, modern Material Design 3 UI
- ✅ Native mobile experience (Android & iOS)
- ✅ Real-time grievance tracking with timeline
- ✅ Smart categorization (AI-ready)
- ✅ Multi-language support (coming soon)
- ✅ Accessibility-first design

---

## 🎨 Screenshots

> 📸 Screenshots captured from iPhone 16 Plus simulator

### 📱 App Screens

| Splash & Login | Home Dashboard | File Grievance |
|----------------|----------------|----------------|
| <img src="https://github.com/user-attachments/assets/fd7ad75c-1a0c-4911-88c3-9fd269368098" width="300" /> | <img src="https://github.com/user-attachments/assets/a3e95a0b-7bcb-4f63-a534-dc46bd87a980" width="300" /> | <img src="https://github.com/user-attachments/assets/d17a41ea-34b5-46e2-a1a8-c614a9afc49a" width="300" /> |

| Grievance List | Detail View | Timeline |
|----------------|-------------|----------|
| <img src="https://github.com/user-attachments/assets/26964375-0688-41af-89cd-254669647610" width="300" /> | <img src="https://github.com/user-attachments/assets/7049a683-987a-4a30-bc23-bc10bcfa79b8" width="300" /> | <img width="1290" height="2796" alt="Simulator Screenshot - iPhone 16 Plus - 2025-12-15 at 14 26 47" src="https://github.com/user-attachments/assets/712063c0-8a9a-4dfd-9bfa-526a9314dfa6" />
|

---

## ✨ Features

### Core Features (Implemented)
- 🔐 **OTP-based Authentication** - Secure phone number verification
- 📝 **File Grievances** - Simple form with category selection
- 📊 **Dashboard** - View stats and recent grievances
- 🔍 **Search & Filter** - Find grievances by status, category, or keyword
- 📈 **Timeline View** - Track grievance progress in real-time
- 👤 **Profile Management** - User info and logout

### Coming Soon
- 🎤 Voice input for filing grievances
- 📸 Image upload with preview
- 🗺️ Location picker with maps
- 🤖 AI-powered category suggestion
- 🔔 Push notifications
- 🌐 Multi-language support (Hindi, English, and more)

---

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.x** - Cross-platform mobile framework
- **Dart 3.x** - Programming language
- **Riverpod 2.4+** - State management
- **Material Design 3** - UI design system

### Planned Backend
- **Python 3.11** - Backend language
- **FastAPI** - REST API framework
- **PostgreSQL** - Primary database
- **Docker** - Containerization

### Tools & Libraries
- \`flutter_riverpod\` - State management
- \`intl\` - Date formatting and localization
- Git & GitHub - Version control

---

## 📁 Project Structure

\`\`\`
lib/
├── main.dart                 # App entry point
├── app.dart                  # Root app widget
├── config/
│   ├── routes.dart           # Navigation routes
│   └── theme.dart            # App theme (light/dark)
├── models/
│   └── grievance_model.dart  # Data models
├── providers/
│   ├── auth_provider.dart    # Authentication state
│   └── grievance_provider.dart # Grievance state
├── screens/
│   ├── splash/
│   │   └── splash_screen.dart
│   ├── login/
│   │   └── login_screen.dart
│   ├── home/
│   │   └── home_screen.dart
│   ├── grievance/
│   │   ├── file_grievance_screen.dart
│   │   ├── grievance_list_screen.dart
│   │   └── grievance_detail_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── widgets/
│   ├── custom_button.dart    # Reusable button
│   ├── custom_text_field.dart # Reusable input field
│   └── status_badge.dart     # Status indicator
└── utils/
    └── validators.dart       # Form validators
\`\`\`

---

## 🏗️ Architecture

\`\`\`
┌─────────────────────────────────────┐
│         Flutter UI Layer            │
│  (Screens, Widgets, Navigation)     │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      State Management Layer         │
│         (Riverpod Providers)        │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Data Layer (Mock)           │
│    (Models, Mock Data Storage)      │
└─────────────────────────────────────┘
               │
        [ Future: REST API ]
               │
┌──────────────▼──────────────────────┐
│    Backend (Coming Soon)            │
│  FastAPI + PostgreSQL + Docker      │
└─────────────────────────────────────┘
\`\`\`

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- iOS Simulator (Mac) or Android Emulator

### Installation

1. **Clone the repository**
   \`\`\`bash
   git clone https://github.com/YOUR_USERNAME/CPGRAMS-NextGen.git
   cd CPGRAMS-NextGen
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   flutter pub get
   \`\`\`

3. **Run the app**
   \`\`\`bash
   # For Android
   flutter run

   # For iOS (Mac only)
   flutter run -d ios

   # For specific device
   flutter devices
   flutter run -d <device_id>
   \`\`\`

### Test Credentials

For development/testing:
- **Phone Number**: Any 10-digit number
- **OTP**: \`123456\`

---

## 📖 Usage Guide

### Filing a Grievance

1. Launch app and login with OTP
2. Tap **"File New Grievance"** on home screen
3. Select category (e.g., Public Works, Water Supply)
4. Enter title (min 10 characters)
5. Describe issue in detail (min 20 characters)
6. Add location
7. Tap **"Submit Grievance"**
8. Note your Grievance ID for tracking

### Tracking Grievances

1. Navigate to **"My Grievances"** from home
2. Use search bar or filters to find specific grievances
3. Tap any grievance card to view details
4. Check timeline for current status

---

## 🧪 Testing

\`\`\`bash
# Run unit tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart

# Check code coverage
flutter test --coverage
\`\`\`

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (\`git checkout -b feature/AmazingFeature\`)
3. Commit your changes (\`git commit -m 'Add some AmazingFeature'\`)
4. Push to the branch (\`git push origin feature/AmazingFeature\`)
5. Open a Pull Request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct.

---

## 🗺️ Roadmap

### Phase 1: Core UI ✅ (Current)
- [x] Authentication flow
- [x] File grievance form
- [x] Grievance list with filters
- [x] Detail view with timeline
- [x] Profile management

### Phase 2: Enhanced Features 🚧 (Next)
- [ ] Voice input
- [ ] Image upload
- [ ] Location picker
- [ ] Push notifications

### Phase 3: Backend Integration
- [ ] FastAPI backend
- [ ] PostgreSQL database
- [ ] Real authentication
- [ ] File storage (S3/MinIO)

### Phase 4: Advanced Features
- [ ] AI category suggestion
- [ ] Multi-language support
- [ ] Offline mode
- [ ] Admin dashboard

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ��‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your Name](https://linkedin.com/in/yourprofile)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- Inspired by India's CPGRAMS (Centralized Public Grievance Redress and Monitoring System)
- Flutter team for the amazing framework
- Material Design team for design guidelines
- Open source community

---

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/yourusername/CPGRAMS-NextGen?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/CPGRAMS-NextGen?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/yourusername/CPGRAMS-NextGen?style=social)

---

<div align="center">
  <strong>Made with ❤️ for better governance</strong>
</div>
