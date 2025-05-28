# UI Global Event Bus 🚌
A lightweight Flutter package that lets you dispatch and handle global UI events—SnackBars, navigation (Material Navigator), dialogs, and even arbitrary callbacks—from anywhere in your app with a single, centralized event bus.

<br>

# 📸 Preview
<!-- <img width=30% src='https://github.com/user-attachments/assets/37f55327-5f0c-4c4c-a44d-8aa248a414b5'>
<img width=30% src='https://github.com/Dansot4891/bouncy_background/raw/main/screenshots/example_view_2.gif'>
 -->

<br>
<br>

# 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  global_event_bus: ^1.0.0
```
or
```
flutter pub get global_event_bus
```

# 🚀 Quick Start
### 1. Wrap Material app and Set Scaffold & Navigate keys on Material
```
void main() {
  runApp(
    UIGlobalEventBus(
      // ① wrap your MaterialApp
      MaterialApp(
        home: const EventEx1(),
        scaffoldMessengerKey: eventScaffoldKey,  // required
        navigatorKey: eventNavigateKey,          // required
      ),

      // ② optional custom callback
      customEvent: (BuildContext ctx) {
        print('Custom event triggered!');
      },
    ),
  );
}
```
<br>

### 2. Dispatch events
Anywhere in your code, use the helpers to fire global UI events:
```
## SnackBar
EventHelpers.showSnackBar('message');

## Navigate
EventHelpers.navigate(
    builder: const EventEx2(),
    navigateMethod: NavigationMethod.push,
);

## Pop
EventHelpers.pop();

## Dialog
EventHelpers.showDialog(
    builder: (ctx) => const AlertDialog(
        title: Text('title'),
        content: Text('context'),
    ),
);

## Custom Event
EventHelpers.eventCustom();
```

<br>

## ⭐️ Features

- **One-Line UI Events**  
  Dispatch SnackBars, navigation (push/go), pop actions, dialogs, and custom callbacks with a single method call—no need to pass `BuildContext` around or wire up listeners everywhere.

- **Global Singleton Bus**  
  Behind the scenes it’s just a singleton broadcast stream, so you can fire events from anywhere and handle them in one central place.

- **Zero Boilerplate Setup**  
  Wrap your `MaterialApp` in `UIGlobalEventBus` (or use `EventBusMaterialApp`), supply the two keys once, and you’re done—no more scattered `navigatorKey` or `scaffoldMessengerKey` hacks.

- **Built-In Pop Handling**  
  Includes a dedicated `pop()` event with optional result payload, so you don’t need separate code to pop the navigation stack.

- **Type-Safe & Extensible**  
  Clear method signatures and event classes keep your code compile-time checked, and you can add your own event types if needed.


# ⚙️ Details
| Method                                                                 | Signature                                                                                                       | Description                                                          |
| ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| `showSnackBar(String message)`                                         | `showSnackBar(String message)`                                                                                   | Dispatches a SnackBar event                                          |
| `navigate({ required Widget page, required NavigationMethod navigateMethod = NavigationMethod.go })` | `navigate({ required Widget page, NavigationMethod navigateMethod = NavigationMethod.go})`                                  | Dispatches a navigation event (push/go) to the given `page`         |
| `pop({ dynamic extra })`                                              | `pop({ dynamic extra })`                                                                                        | Pops the current route; if `extra` is provided, it’s returned to the previous route |
| `showDialog({ required Widget Function(BuildContext) builder, bool barrierDismissible = true })` | `showDialog({ required Widget Function(BuildContext) builder, bool barrierDismissible = true })`              | Dispatches a dialog event                                            |
| `customEvent()`                                    | `customEvent()`                                                                              | Invokes the user-defined callback registered in `UIGlobalEventBus`   |

#### Parameters

- **`message`** (`String`):  
  The text to display in the SnackBar.

- **`page`** (`Widget`):  
  The destination widget to navigate to.

- **`navigateMethod`** (`NavigationMethod`):  
  The navigation action type:  
  - `push` – Push the `page` onto the stack  
  - `go`   – Replace the current route with the `page`
  - Defaults to `go`.

- **`extra`** (`dynamic`):  
  Optional value returned when popping the current route.

- **`builder`** (`Widget Function(BuildContext)`):  
  A function that returns the dialog widget.

- **`barrierDismissible`** (`bool`):  
  Whether tapping outside dismisses the dialog. Defaults to `true`.

