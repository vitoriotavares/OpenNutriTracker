# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**OpenNutriTracker** is a privacy-focused, open-source nutrition tracking mobile application built with Flutter. It allows users to log meals, track calories and macronutrients, scan food barcodes, and monitor physical activities across Android, iOS, web, and macOS platforms.

- **Framework**: Flutter 3.27.1 (Dart SDK >=3.0.0 <4.0.0)
- **Architecture**: Clean Architecture with BLoC pattern for state management
- **Key Features**: Food logging, barcode scanning, nutritional calculations, data export/import, multi-language support (English, German, Turkish)
- **License**: GNU General Public License v3.0
- **Data Storage**: Hive (local NoSQL database) with encrypted sensitive data

## Essential Development Commands

### Setup & Installation

```bash
# Get dependencies
flutter pub get

# Generate code (JSON serialization, Hive adapters, environment variables)
flutter pub run build_runner build --delete-conflicting-outputs

# When modifying annotated classes, use:
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running the App

```bash
# Default (debug on Android or iOS emulator)
flutter run lib/main.dart

# Platform-specific
flutter run -d chrome          # Web
flutter run -d ios             # iOS simulator
flutter run -d android         # Android emulator/device
flutter run -d macos           # macOS
```

### Code Quality & Testing

```bash
# Static analysis (enforces flutter_lints rules)
flutter analyze

# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate app icons from assets
flutter pub run flutter_launcher_icons
```

### Build & Release

```bash
# Debug build
flutter build apk              # Android APK
flutter build ios              # iOS (requires Xcode)
flutter build appbundle        # Android App Bundle for Play Store
flutter build web              # Web build
```

## Code Architecture

### Layer Organization

```
lib/
├── core/                       # Shared layer (not tied to specific features)
│   ├── data/                   # Data layer - repositories, data sources, DBOs
│   ├── domain/                 # Domain layer - entities, use cases, business logic
│   ├── presentation/           # Shared UI - main navigation, reusable widgets
│   ├── styles/                 # Theme, colors, typography (Material 3)
│   └── utils/                  # Utilities: calculators, DI, logging, env vars
│
└── features/                   # Feature modules (each with data/domain/presentation)
    ├── home/                   # Dashboard/home screen
    ├── diary/                  # Food diary view
    ├── add_meal/               # Meal search and creation (integrates FDC and Open Food Facts APIs)
    ├── scanner/                # Barcode scanning
    ├── meal_detail/            # View/edit meal details
    ├── edit_meal/              # Meal editing
    ├── activity_detail/        # Physical activity details
    ├── add_activity/           # Add activity logging
    ├── profile/                # User profile management
    ├── settings/               # App settings (export/import)
    └── onboarding/             # First-run user setup
```

### Key Architectural Patterns

- **Clean Architecture**: Clear separation between Data, Domain, and Presentation layers
- **BLoC Pattern**: All feature screens use `flutter_bloc` for state management
- **Repository Pattern**: Data access abstraction in repositories (data layer)
- **Dependency Injection**: `GetIt` service locator in `core/utils/locator.dart`
- **Entity-DTO Separation**: Domain entities separate from API DTOs

### Data Layer Details

- **Database**: Hive (NoSQL, local storage)
  - Adapters auto-generated via `hive_generator`
  - Initialized in `core/utils/hive_db_provider.dart`
- **External APIs**:
  - USDA Food Data Central (FDC) - `FDC_API_KEY` required
  - Open Food Facts - free, no key needed
- **Encryption**: `flutter_secure_storage` for sensitive user data

## Configuration & Environment

### Environment Variables (.env)

Create a `.env` file in the project root:

```
FDC_API_KEY="your_usda_api_key"
SENTRY_DNS="your_sentry_endpoint"
SUPABASE_PROJECT_URL="your_supabase_url"
SUPABASE_PROJECT_ANON_KEY="your_supabase_key"
```

Environment variables are type-safe via `envied` package and auto-generated during build.

### Flutter Version Management

```bash
# Install FVM if needed
brew install fvm

# Use pinned Flutter version (3.27.1 defined in .fvmrc)
fvm flutter pub get
fvm flutter run
```

## Testing

### Test Structure

```
test/
├── unit_test/                  # Business logic tests (calculators, repositories)
├── widget_test/                # UI component tests
└── fixture/                    # Test data and mock objects
```

### Writing Tests

- Unit tests for calculators (BMI, BMR, TDEE, calorie goals)
- Repository tests verify data persistence
- Use `mockito` for mocking dependencies
- Fixtures in `test/fixture/` provide reusable test data

### Running Tests

```bash
flutter test                        # All tests
flutter test test/unit_test/        # Only unit tests
flutter test -v                     # Verbose output
```

## State Management (BLoC Pattern)

- Each feature typically has multiple BLoCs for different concerns
- BLoCs live in `features/[feature]/presentation/bloc/`
- Use `flutter_bloc` library (v8.1.6+)
- Pattern: Events → BLoC → States (all inherit from `Equatable`)

## Localization

- **Languages**: English, German, Turkish (in `lib/l10n/`)
- **Format**: ARB files (`intl_en.arb`, `intl_de.arb`, `intl_tr.arb`)
- **Access**: Use `AppLocalizations.of(context)?.key` or `context.l10n.key`
- **Code Generation**: Auto-generated in `lib/generated/l10n.dart`

## UI & Theming

- **Material Design 3**: Full support with dynamic theming
- **Colors**: Defined in `core/styles/color_schemes.dart` (light/dark modes)
- **Typography**: Poppins font family with all weights (Thin to Black)
- **Custom Icons**: `CustomIcons` font in `fonts/CustomIcons.ttf`
- **Responsive**: Use `auto_size_text` and `percent_indicator` widgets

## Key Dependencies & Usage

### State Management
- `flutter_bloc` - Reactive state management
- `get_it` - Service locator/DI container
- `provider` - Theme management

### Data & Storage
- `hive` / `hive_flutter` - Local NoSQL database
- `http` - HTTP client for APIs
- `flutter_secure_storage` - Encrypted secure storage
- `supabase_flutter` - Backend service integration

### UI Widgets
- `flutter_svg` - SVG rendering
- `cached_network_image` - Image caching
- `table_calendar` - Calendar widget
- `introduction_screen` - Onboarding flows
- `mobile_scanner` - Barcode scanning

### Code Generation
- `json_serializable` - JSON encoding/decoding
- `hive_generator` - Hive adapter generation
- `envied_generator` - Environment variable generation
- `build_runner` - Code generation orchestration

## Git Workflow

- **Main branch**: `main` - production-ready code
- **Development branch**: `develop` - integration branch
- **Feature branches**: Create from `develop`
- **Commits**: Follow conventional commits (feat:, fix:, chore:, etc.)
- **Deployment**: Manual (not automated in CI/CD)

## CI/CD Pipeline (.github/workflows/default_workflow.yml)

Pipeline runs on: `main` and `develop` push/PR, plus manual workflow dispatch

**Steps**:
1. Checkout code
2. Setup Java (Zulu JDK 11 for Android)
3. Setup Flutter 3.27.1
4. Cache pub dependencies
5. Install dependencies (`flutter pub get`)
6. Generate code (`build_runner`)
7. Analyze code (`flutter analyze`)
8. Run tests (`flutter test`)

**Secrets** (configure in GitHub):
- `FDC_API_KEY`
- `SENTRY_DNS`
- `SUPABASE_PROJECT_URL`
- `SUPABASE_PROJECT_ANON_KEY`

## Common Development Tasks

### Adding a New Feature

1. Create feature folder in `lib/features/[feature_name]/`
2. Structure: `data/`, `domain/`, `presentation/` subdirectories
3. Create data sources, repositories, use cases
4. Implement BLoCs for state management
5. Build UI screens and widgets
6. Run `flutter pub run build_runner build`
7. Add tests in `test/`

### Working with Hive Database

1. Create entity class with `@HiveType()` annotation
2. Run `flutter pub run build_runner build` to generate adapter
3. Register adapter in `hive_db_provider.dart`
4. Use repository pattern for data access
5. Sensitive data stored with `flutter_secure_storage`

### Integrating External APIs

- FDC (USDA): Requires `FDC_API_KEY` in `.env`
- Open Food Facts: Free API, no key needed
- Both integrated in `features/add_meal/data/data_sources/`
- Use DTOs to parse responses, map to domain entities in repository

### Updating Dependencies

```bash
flutter pub outdated              # Check for updates
flutter pub upgrade               # Upgrade to latest allowed versions
flutter pub upgrade --major-versions  # Include major version updates
```

After updating, always run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
```

## Code Style & Linting

- Extends `package:flutter_lints/flutter.yaml`
- Run `flutter analyze` to check code quality
- Use IDE formatter (Dart built-in) for consistent formatting
- Follow Dart/Flutter naming conventions (camelCase variables, PascalCase classes)

## Key Files to Know

- `lib/main.dart` - App entry point, Sentry initialization
- `lib/core/presentation/main_screen.dart` - Main navigation shell
- `lib/core/utils/locator.dart` - Dependency injection setup
- `lib/core/utils/hive_db_provider.dart` - Database initialization
- `lib/core/styles/color_schemes.dart` - Theme definitions
- `lib/core/utils/calc/` - Nutritional calculation utilities
- `pubspec.yaml` - All dependencies and asset declarations

## Performance & Optimization Notes

- Barcode scanning can be resource-intensive; consider platform channels for optimization
- Image caching via `cached_network_image` to reduce network requests
- Hive database is efficient for local storage; consider pagination for large datasets
- BLoC rebuilds only when state changes (use `Equatable`)

## Debugging Tips

- Use `flutter devtools` for widget inspection and performance profiling
- Check logs with `flutter logs`
- Use VS Code debugger configuration in `.vscode/launch.json`
- Sentry integration (optional, user-consent based) helps track production errors
