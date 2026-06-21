# Application Architecture Guideline

This project follows **Clean Architecture** principles combined with a **Feature-First** structure. It provides separation of concerns, decouples business rules from the UI, and enables parallel, modular feature development.

---

## 1. Directory Structure

The project root structure under `lib/` separates core setup, shared UI/utilities, and business features:

```text
lib/
├── app/                  # Application-wide bootstrap, global router, and themes
│   ├── app.dart
│   ├── router/           # Navigation configuration (GoRouter)
│   └── theme/            # Theme definitions (Material Light/Dark + custom Extensions)
│
├── core/                 # Shared foundations, non-UI utilities, services
│   ├── constants/        # System-wide static variables
│   ├── errors/           # System-wide error declarations
│   ├── network/          # Http client, base URL, interceptors, ApiException
│   ├── storage/          # Local preference and secure storage wrappers
│   └── utils/            # General Dart extensions and helper utilities
│
├── shared/               # Shared visual components, widgets, resources
│   └── widgets/          # Global reusable UI (scaffolds, buttons, inputs, etc.)
│
└── features/             # Business feature modules (empty starter folder)
```

### Feature Module Structure

Every feature module created inside `features/` MUST strictly follow this sub-folder pattern:

```text
feature_name/
├── data/
│   ├── datasources/      # Remote API or local database client requests
│   ├── models/           # Data Transfer Objects (DTOs) for JSON serialization
│   └── repositories/     # Repository implementations fetching from datasources
│
├── domain/
│   ├── entities/         # Pure Dart business data structures (no framework imports)
│   └── repositories/     # Abstract repository interfaces
│
└── presentation/
    ├── controllers/      # Riverpod Notifiers/StateControllers managing logic
    ├── pages/            # Scaffold screens matching Figma mockups
    ├── states/           # Presentation UI state definitions
    └── widgets/          # Private widgets specific to this feature page only
```

---

## 2. Core Architectural Patterns

### The Repository Pattern
- **Decoupled Data Layer**: Repositories act as the single source of truth between the `data` layer (network/local data) and the `domain` layer.
- **Interfaces in Domain**: The `domain` layer defines the contract (abstract classes), while the `data` layer implements it. This keeps business rules testable.

### SOLID Principles
- **Single Responsibility**: Every class has a single purpose. Controllers manage UI state; Repositories manage data fetching; DataSources manage raw network requests.
- **Composition over Inheritance**: Widgets compose small, modular UI elements (like `AppCard` and `AppText`) rather than inheriting from complex base widgets.

---

## 3. Dependency Evaluation & Package Strategy

To keep the starter kit robust, we rely on popular, actively maintained packages. Below is our package selection audit:

### State Management: Riverpod
- **Why it is needed**: Handles state distribution, caching, dependency injection, and reactivity.
- **Alternative Options**: `flutter_bloc` (Bloc), `Provider`.
- **Reason Selected**: Riverpod is compile-safe, does not depend on the widget tree for lookup, provides superior testing capability, and automatically resolves dependency disposal compared to Bloc or standard Provider.

### Navigation: GoRouter
- **Why it is needed**: Declarative routing system for mobile apps, essential for deep-linking and state preservation.
- **Alternative Options**: `auto_route`, Native Navigator 2.0.
- **Reason Selected**: GoRouter is the official routing package recommended by the Flutter team. It has robust support for nested tabs, parameter parsing, and is much simpler than building custom shell navigation from scratch.

### Networking: Dio
- **Why it is needed**: Advanced HTTP client for network requests.
- **Alternative Options**: `http` package.
- **Reason Selected**: Dio provides rich support out-of-the-box for request interception (attaching tokens, refreshing JWTs), request cancellation, global headers, and automatic timeout handling.

### Local Preferences: shared_preferences
- **Why it is needed**: Key-value persistent storage for non-sensitive values (theme preferences, locale).
- **Alternative Options**: `hive`, `sqlite`.
- **Reason Selected**: SharedPreferences is lightweight, cross-platform native, and requires zero database engine setup, making it ideal for simple client configurations.

### Sensitive Storage: flutter_secure_storage
- **Why it is needed**: Keychain/Keystore wrapper to save sensitive auth tokens securely.
- **Alternative Options**: Custom platform channel integrations.
- **Reason Selected**: Provides standard OS-level keychain encryption with simple Dart APIs, ensuring JWTs are encrypted on iOS/Android.

### Loading Placeholders: skeletonizer
- **Why it is needed**: Renders modern skeleton load animations directly from actual widget structures.
- **Alternative Options**: `shimmer` package.
- **Reason Selected**: Shimmer requires writing separate mockup layouts. Skeletonizer applies a skeleton effect to your *actual* widgets, reducing boilerplate by 90%.

### Visual Icons: lucide_icons
- **Why it is needed**: Consistent, premium vector icon library.
- **Alternative Options**: CupertinoIcons, FontAwesome.
- **Reason Selected**: Lucide provides minimal, modern line icons that align perfectly with modern Apple HIG aesthetics.
