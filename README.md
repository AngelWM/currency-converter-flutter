# currency-converter-flutter
AE1
# Currency Converter

A mobile currency converter built with **Flutter and Dart**. Users can enter an amount, select a source and target currency, and see the converted value and applied exchange rate update immediately. The application uses a fixed exchange-rate table, so it does not require an external API or internet connection to calculate conversions.

## Features

- **Live conversion:** The result and exchange-rate display update as the amount or either currency selection changes—no Convert button is needed.
- **Five currencies:** US Dollar (USD), British Pound (GBP), Euro (EUR), Japanese Yen (JPY), and Nigerian Naira (NGN).
- **One-tap swap:** Exchange the source and target currencies using the swap icon.
- **Applied rate display:** See the rate for the currently selected currency pair.
- **Input handling:** Supports zero and decimal amounts; displays guidance for empty, invalid, negative, or excessively large values.
- **Consistent interface:** Material Design controls, a prominent result card, and a vertically scrollable layout.

## How It Works

### Fixed Exchange Rates

The application stores illustrative exchange rates as the number of currency units equivalent to **1 USD**. These values are hard-coded for the exercise and are not current market rates.

| Currency | Units per 1 USD |
|---|---:|
| USD | 1.00 |
| GBP | 0.79 |
| EUR | 0.92 |
| JPY | 150.00 |
| NGN | 1450.00 |

For any selected currency pair:

**Exchange Rate = Target Currency Rate / Source Currency Rate**

**Converted Amount = Entered Amount × Exchange Rate**

For example, converting **100 USD to GBP** gives `100 × (0.79 / 1.00) = 79.00 GBP`.

Reversing the direction produces **100 GBP ≈ 126.58 USD**. The converted amount is displayed to two decimal places.

### Live Updates and State Management

The converter uses a single `StatefulWidget` and Flutter's built-in `setState()` method. Its state contains the amount text, the source currency and the target currency.

Whenever one of these inputs changes, the widget rebuilds and calculates the result and applied rate from the latest values.

The swap icon exchanges both selected currencies in one `setState()` call. The calculated result is not stored as separate state, helping to prevent stale values.

## Technologies

- Flutter and Dart
- Material Design widgets
- `StatefulWidget` and `setState()`
- `flutter_test` for widget testing

No third-party packages, network services or advanced state-management frameworks are required.

## Project Structure

The project contains the following files:

| Path | Purpose |
|---|---|
| `lib/main.dart` | Application UI, state and conversion logic |
| `test/widget_test.dart` | Automated widget tests |
| `pubspec.yaml` | Flutter project configuration |
| `.gitignore` | Git exclusions |
| `README.md` | Project documentation |

This is a source-only project layout. Standard Flutter platform folders, such as `android/` and `ios/`, can be generated during local setup.

## Installation and Running

### Prerequisites

- Flutter SDK (including Dart)
- VS Code or Android Studio
- A supported device, emulator or browser target

### Setup

1. Download or clone the repository and open the extracted project folder in your editor.
2. Open a terminal in the folder containing `pubspec.yaml`.
3. If the Flutter platform folders have not been generated, run `flutter create .`.
4. Install dependencies using `flutter pub get`.
5. Run the application using `flutter run`.

Use `flutter devices` to inspect available devices.

## Testing and Validation

Automated widget tests are located in `test/widget_test.dart`. They cover amount changes, live conversion, currency swapping, zero and negative inputs, and updates to the currency selectors.

Run the following checks from the project root:

- `flutter analyze`
- `flutter test`

The following manual tests can also be performed:

| Scenario | Expected result |
|---|---|
| Enter 100, USD → GBP | 79.00 GBP |
| Change 100 to 200, USD → GBP | 158.00 GBP immediately |
| Enter 100, GBP → USD | Approximately 126.58 USD |
| Tap Swap | Source and target reverse; result recalculates |
| Select the same currency twice | Exchange rate is 1 |
| Enter 0 | Result displays 0.00 |
| Enter a decimal amount | Decimal value is calculated correctly |
| Enter an invalid or negative amount | Validation message without a crash |
| Change either dropdown | Applied rate and result update immediately |
| Use a narrow display | Content remains reachable by scrolling |

**Verification status:** Record the actual results of `flutter analyze`, `flutter test` and device testing after running them.

## UI/UX Design Decisions

**Clear visual hierarchy:** A prominent result card makes the conversion outcome easy to identify.

**Logical grouping:** Amount entry, source selection, target selection and swap are grouped together.

**Consistent styling:** Shared spacing, rounded containers and standard Material controls keep the interface cohesive.

**Immediate feedback:** Changes are reflected without an extra confirmation step.

**Error prevention:** Invalid values are handled with guidance rather than an application crash.

**Smaller-screen usability:** The content is placed in a scrollable area to reduce overflow.

## Video Demonstration

The application demonstration shows entering an amount, selecting currencies, live updates, swapping currencies and handling invalid input.


## Limitations

- Rates are fixed examples and may differ significantly from actual exchange rates.
- There is no live API, transaction functionality or currency-rate history.
- The application is intended for learning and demonstration, not financial transactions.
