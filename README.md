# StockList

## Architecture

The app uses a Redux-like approach for managing screen state and handling user actions.  
The main flow is:  
**The View sends an Action to the ViewModel → The ViewModel fetches/updates data, generates internal events, and sends them to the Reducer → The Reducer applies changes to the state → The View renders the UI based on the updated state.**

The project also follows key **Clean Architecture** principles, with clear separation between **Domain**, **UseCases**, and **View** layers. This helps prevent higher-level modules from depending on lower-level ones and keeps business logic, data, and presentation separate and maintainable.

### Main benefits of this approach

- State is changed only in one place — the `reduce` function.
- `ViewModel.send()` is the entry point for business and presentation logic.
- The View is a pure function that receives State and renders the UI.
- Easy to test, mock, and use in previews.
- The codebase is simple to read, maintain, and scale.
- Multiple developers can work on the same feature in parallel without blocking each other.

## What I would improve in a production project

1. **Localization**  
   Move all strings to separate localizable files to support multiple languages and make translations easier.

2. **Tuist or XcodeGen**  
   Use Tuist or XcodeGen for centralized project configuration, faster creation of new targets, and better CI integration.

3. **CI/CD**  
   Set up a CI/CD pipeline (for example, GitHub Actions) to automate builds, run tests, and check code quality on every commit.

4. **SwiftLint / SwiftFormat**  
   Introduce linters and auto-formatting to enforce consistent code style and catch potential issues early during pull requests.

5. **App Monitoring / Crashlytics**  
   Integrate monitoring tools like Crashlytics or Sentry to quickly track crashes and bugs in production.