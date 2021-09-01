Package to validate the indian identification numbers such as PAN, AADHAAR, etc.
This package will not validate the numbers with any govt. data.
It just validates the numbers with some regular expressions and algorithms.

## Features

- validate PAN
- validate AADHAAR
- validate Driving License Number

## Getting started

add the following dependency in pubspec.yml

```dart
dependencies:
  in_validator: {version}
```

## Usage

```dart
import 'package:in_validator/in_validator.dart';

// PAN
PANValidator().isValid('XXXXX9999X');

// AADHAAR
AadhaarValidator().isValid('999941057058');

// DRIVING LICENCSE
DrivingLicenseValidator().isValid('HR-0620220034761');

```
see the `example` app for more details.

## Additional information

Live Demo: https://deepak786.github.io/in_validator_demo

Don't hesitate to buy me a coffee.
<a href="https://www.buymeacoffee.com/deepakdroid" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" width="150px"></a>
