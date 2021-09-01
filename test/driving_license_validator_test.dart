import 'package:flutter_test/flutter_test.dart';
import 'package:in_validator/in_validator.dart';

void main() {
  late DrivingLicenseValidator dlValidator;
  setUpAll(() {
    dlValidator = DrivingLicenseValidator();
  });

  // valid
  test("isValid", () {
    expect(dlValidator.isValid(null), false);
    expect(dlValidator.isValid(''), false);
    expect(dlValidator.isValid('HR'), false);
    expect(dlValidator.isValid('123456789012345'), false);
    expect(dlValidator.isValid('HR-0619850034761'), true);
    expect(dlValidator.isValid('HR06 19850034761'), true);
    expect(dlValidator.isValid('HR0619850034761'), true);
    expect(dlValidator.isValid('HR-0618990034761'), false);
    expect(dlValidator.isValid('HR-0620220034761'), false);
  });

  // format
  test("format", () {
    expect(dlValidator.format(null), null);
    expect(dlValidator.format(''), '');
    expect(dlValidator.format('HR'), 'HR');
    expect(dlValidator.format('hr06'), 'HR-06');
    expect(dlValidator.format('HR-0619850034761'), 'HR-0619850034761');
    expect(dlValidator.format('HR06 19850034761'), 'HR-0619850034761');
    expect(dlValidator.format('HR', withHyphen: false), 'HR');
    expect(dlValidator.format('hr06', withHyphen: false), 'HR06');
    expect(dlValidator.format('HR-0619850034761', withHyphen: false),
        'HR06 19850034761');
    expect(dlValidator.format('HR06 19850034761', withHyphen: false),
        'HR06 19850034761');
  });
}
