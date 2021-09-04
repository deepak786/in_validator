class PassportValidator {
  /// validate the passport number.
  ///
  /// The valid passport number of India must satisfy the following conditions:
  ///
  /// 1. It should be eight characters long.
  /// 2. The first character should be an upper case alphabet except Q, X, and Z.
  /// 3. The next two characters should be a number, but the first character should be any number from 1-9 and the second character should be any number from 0-9.
  /// 4. The next four characters should be any number from 0-9.
  /// 5. The last character should be any number from 1-9.
  ///
  /// see https://www.geeksforgeeks.org/how-to-validate-indian-passport-number-using-regular-expression/
  factory PassportValidator() {
    _instance ??= PassportValidator._();
    return _instance!;
  }

  PassportValidator._();

  static PassportValidator? _instance;

  /// function to check if the provided [passport] is valid or not.
  ///
  /// returns true of the [passport] number seems valid.
  bool isValid(String? passport) {
    if (passport == null) return false;

    // remove the spaces from passport
    passport = passport.replaceAll(RegExp(r"\s+"), "");

    if (passport.length != 8) {
      // passport number length must be 8
      return false;
    }

    RegExp passportRegEx = RegExp(r"^[A-PR-WYa-pr-wy][1-9][0-9][0-9]{4}[1-9]$");
    return passportRegEx.hasMatch(passport);
  }

  /// passport format can be
  /// A21 90457 or A2190457
  ///
  String? format(String? passport, {bool withSpace = false}) {
    if (passport == null) return null;

    // remove the spaces
    passport = passport.replaceAll(RegExp(r"\s+"), "");

    if (withSpace) {
      if (passport.length > 3) {
        return (passport.substring(0, 3) + " " + passport.substring(3))
            .toUpperCase();
      }
    }

    return passport.toUpperCase();
  }
}
