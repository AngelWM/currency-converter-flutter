# Currency Converter (Flutter)

## Overview

This project is a simple currency converter developed using Flutter and Dart as part of software engineering practice. The application allows users to enter an amount, choose a source currency and a target currency, and instantly view the converted value.

The application uses a small set of predefined exchange rates stored locally within the project, allowing conversions to be performed without an internet connection or external API.

## Features

- Convert between USD, GBP, EUR, JPY and NGN
- Live conversion updates as values change
- Swap source and target currencies with a single tap
- View the exchange rate used for each conversion
- Input validation for invalid or negative values
- Responsive and scrollable interface built with Flutter Material widgets

## Technologies Used

- Flutter
- Dart
- Material Design
- StatefulWidget
- setState()

No third\-party packages or external APIs were used.

## Project Structure

lib/

 └── main.dart

test/

 └── widget\_test.dart

pubspec.yaml

README.md

.gitignore

## Running the Application

### Prerequisites

- Flutter SDK
- Dart SDK
- VS Code or Android Studio

### Installation

1. Clone the repository:

git clone [https://github.com/AngelWM/currency\-converter\-flutter.git](https://github.com/AngelWM/currency-converter-flutter.git)

1. Navigate to the project folder:

cd currency\-converter\-flutter

1. Install dependencies:

flutter pub get

1. Run the application:

flutter run

## How the Converter Works

The application stores a set of predefined exchange rates for five currencies:

- USD
- GBP
- EUR
- JPY
- NGN

Exchange rates are used to calculate the conversion between the selected currencies. Whenever the amount or currency selections change, the result updates automatically using Flutter's setState() method.

The swap button allows users to quickly reverse the currency pair and recalculate the result.

## Testing

The project includes widget tests located in the test directory.

Useful commands:

flutter analyze

flutter test

Example test scenarios:

- Convert USD to GBP
- Convert GBP to USD
- Swap currencies
- Enter decimal values
- Enter invalid input
- Enter negative values
- Select identical currencies

## Design Decisions

Several design choices were made to improve usability:

- A large result card makes the converted value easy to identify.
- Currency selectors are grouped with the amount input field.
- Results update automatically without requiring a separate Convert button.
- Validation messages help prevent incorrect input.
- A scrollable layout helps support smaller screens.

## Limitations

- Exchange rates are fixed and do not update in real time.
- The application is intended for demonstration and learning purposes.
- No historical exchange\-rate data is provided.
- No financial transactions can be performed using the application.

## Repository

[https://github.com/AngelWM/currency\-converter\-flutter](https://github.com/AngelWM/currency-converter-flutter)

