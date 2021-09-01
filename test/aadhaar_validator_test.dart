import 'package:flutter_test/flutter_test.dart';
import 'package:in_validator/in_validator.dart';

void main() {
  late AadhaarValidator aadhaarValidator;

  setUpAll(() {
    aadhaarValidator = AadhaarValidator();
  });

  // valid
  test("isValid", () {
    expect(aadhaarValidator.isValid(""), false);
    expect(aadhaarValidator.isValid("11"), false);
    expect(aadhaarValidator.isValid("AA"), false);
    expect(aadhaarValidator.isValid("123456789011"), false);
    expect(aadhaarValidator.isValid("012345678901"), false);
    expect(aadhaarValidator.isValid("234567890110"), false);
    expect(aadhaarValidator.isValid("AAAAAAAAAAAA"), false);
    expect(aadhaarValidator.isValid("AA123AA1123QQ"), false);
    expect(aadhaarValidator.isValid("999941057058"), true);
    expect(aadhaarValidator.isValid("9999 4105 7058"), true);
    expect(aadhaarValidator.isValid("999971658847"), true);
    expect(aadhaarValidator.isValid("9999 7165 8847"), true);
  });

  // format
  test("format", () {
    expect(aadhaarValidator.format(""), "");
    expect(aadhaarValidator.format("9"), "9");
    expect(aadhaarValidator.format("99"), "99");
    expect(aadhaarValidator.format("999"), "999");
    expect(aadhaarValidator.format("9999"), "9999");
    expect(aadhaarValidator.format("99999"), "9999 9");
    expect(aadhaarValidator.format("999999"), "9999 99");
    expect(aadhaarValidator.format("9999999"), "9999 999");
    expect(aadhaarValidator.format("99999999"), "9999 9999");
    expect(aadhaarValidator.format("999999999"), "9999 9999 9");
    expect(aadhaarValidator.format("9999999999"), "9999 9999 99");
    expect(aadhaarValidator.format("99999999999"), "9999 9999 999");
    expect(aadhaarValidator.format("999999999999"), "9999 9999 9999");
  });
}
