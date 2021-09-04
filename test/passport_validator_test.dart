import 'package:flutter_test/flutter_test.dart';
import 'package:in_validator/in_validator.dart';

void main() {
  late PassportValidator passportValidator;
  setUpAll(() {
    passportValidator = PassportValidator();
  });

  // valid
  test("isValid", () {
    expect(passportValidator.isValid(null), false);
    expect(passportValidator.isValid('A21'), false);
    expect(passportValidator.isValid('A21 90457'), true);
    expect(passportValidator.isValid('A2190457'), true);
    expect(passportValidator.isValid('a21 90457'), true);
    expect(passportValidator.isValid('a2190457'), true);
    expect(passportValidator.isValid('A0296457'), false);
    expect(passportValidator.isValid('Q2096453'), false);
    expect(passportValidator.isValid('12096457'), false);
    expect(passportValidator.isValid('A209645704'), false);
  });

  // format
  test("format", () {
    expect(passportValidator.format(null), null);
    expect(passportValidator.format('a'), 'A');
    expect(passportValidator.format('A21'), 'A21');
    expect(passportValidator.format('A219'), 'A219');
    expect(passportValidator.format('A219', withSpace: true), 'A21 9');
    expect(passportValidator.format('a21 90457'), 'A2190457');
    expect(passportValidator.format('a21 90457', withSpace: true), 'A21 90457');
  });
}
