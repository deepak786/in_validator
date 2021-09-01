import 'package:flutter_test/flutter_test.dart';
import 'package:in_validator/in_validator.dart';

void main() {
  late PANValidator panValidator;
  setUpAll(() {
    panValidator = PANValidator();
  });

  // valid
  test("isValid", () {
    expect(panValidator.isValid(''), false);
    expect(panValidator.isValid('AA'), false);
    expect(panValidator.isValid('AAA99'), false);
    expect(panValidator.isValid('AAA9999A'), false);
    expect(panValidator.isValid('AAAAA99999'), false);
    expect(panValidator.isValid('XXXXXXXXXX'), false);
    expect(panValidator.isValid('9999999999'), false);
    expect(panValidator.isValid('AAAAA9999A'), true);
  });

  // format
  test("format", () {
    expect(panValidator.format(''), '');
    expect(panValidator.format('aa'), 'AA');
    expect(panValidator.format('xxxXXxxxXX'), 'XXXXXXXXXX');
    expect(panValidator.format('aaaaa9999a'), 'AAAAA9999A');
    expect(panValidator.format('AAAAA9999A'), 'AAAAA9999A');
  });
}
