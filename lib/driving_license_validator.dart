class DrivingLicenseValidator {
  /// validate the Driving license number.
  ///
  /// The valid Indian driving license number must satisfy the following conditions:
  ///
  /// 1. It should be 16 characters long (including space or hyphen (-)).
  /// 2. The driving license number can be entered in any of the following formats:
  /// HR-0619850034761
  ///  OR
  /// HR06 19850034761
  /// 3. The first two characters should be upper case alphabets that represent the state code.
  /// 4. The next two characters should be digits that represent the RTO code.
  /// 5. The next four characters should be digits that represent the license issued year.
  /// 6. The next seven characters should be any digits from 0-9.
  ///
  /// See https://www.geeksforgeeks.org/how-to-validate-indian-driving-license-number-using-regular-expression/
  factory DrivingLicenseValidator() {
    _instance ??= DrivingLicenseValidator._();
    return _instance!;
  }

  DrivingLicenseValidator._();

  static DrivingLicenseValidator? _instance;

  /// function to check if the provided [dlNumber] is valid or not.
  ///
  /// returns true if the [dlNumber] seems to be valid.
  ///
  /// This will validate the driving license numbers issued between 1900 to current year.
  bool isValid(String? dlNumber) {
    if (dlNumber == null) return false;

    // remove the space and hyphen (-) from [dlNumber]
    // because the driving license number can have these
    dlNumber = dlNumber.replaceAll(RegExp(r"-|\s+"), "");

    if (dlNumber.length != 15) {
      // driving license number length must be 15 without space or hyphen
      return false;
    }

    int minYear = 1900;
    int maxYear = DateTime.now().year;
    String minYearFirstTwoDigits = minYear.toString().substring(0, 2);
    String maxYearFirstTwoDigits = maxYear.toString().substring(0, 2);
    String yearRegEx =
        "($minYearFirstTwoDigits|$maxYearFirstTwoDigits)[0-9][0-9]";

    RegExp dlRegExp =
        RegExp(r"^([A-Za-z]{2}[0-9]{2})(" + yearRegEx + ")[0-9]{7}\$");
    if (dlRegExp.hasMatch(dlNumber)) {
      // regular expression matched
      // now check the issue year
      int year = int.parse(dlNumber.substring(4, 8));
      return year >= minYear && year <= maxYear;
    }

    return false;
  }

  /// Driving license format is HR-0619850034761 or HR06 19850034761.
  ///
  /// by default it will return with hyphen.
  String? format(String? dlNumber, {bool withHyphen = true}) {
    if (dlNumber == null) return null;

    // remove the space and hyphen (-) from [dlNumber]
    // because the driving license number can have these
    dlNumber = dlNumber.replaceAll(RegExp(r"-|\s+"), "");

    if (withHyphen) {
      if (dlNumber.length > 2) {
        return (dlNumber.substring(0, 2) + '-' + dlNumber.substring(2))
            .toUpperCase();
      }

      return dlNumber.toUpperCase();
    } else {
      if (dlNumber.length > 4) {
        return (dlNumber.substring(0, 4) + ' ' + dlNumber.substring(4))
            .toUpperCase();
      } else {
        return dlNumber.toUpperCase();
      }
    }
  }
}
