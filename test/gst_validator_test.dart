import 'package:flutter_test/flutter_test.dart';
import 'package:in_validator/in_validator.dart';

void main() {
  late GSTValidator gstValidator;
  setUpAll(() {
    gstValidator = GSTValidator();
  });

  // valid
  test("isValid", () {
    expect(gstValidator.isValid(null), false);
    expect(gstValidator.isValid(''), false);
    expect(gstValidator.isValid('1234567890'), false);
    expect(gstValidator.isValid('123456789012345'), false);
    expect(gstValidator.isValid('A0XXXXX9999X9Z0'), false);
    expect(gstValidator.isValid('00XXXXX9999X9Z0'), false);
    expect(gstValidator.isValid('A0XXXXX9999X9Z0'), false);
    expect(gstValidator.isValid('18AABCU9603R1ZM'), true);
    expect(gstValidator.isValid('10AABCU9603R1Z2'), true);
    expect(gstValidator.isValid('10aabcu9603R1z2'), true);
    expect(gstValidator.isValid('10Aabcu9603r1Z2'), true);
  });

  // format
  test("format", () {
    expect(gstValidator.format(null), null);
    expect(gstValidator.format(''), '');
    expect(gstValidator.format('12'), '12');
    expect(gstValidator.format('12a'), '12A');
    expect(gstValidator.format('10aabcu9603r1z2'), '10AABCU9603R1Z2');
  });
}
