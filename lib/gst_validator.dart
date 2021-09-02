class GSTValidator {
  /// validate the GST number.
  ///
  /// The valid GST (Goods and Services Tax) number must satisfy the following conditions:
  ///
  /// 1. It should be 15 characters long.
  /// 2. The first 2 digits denote the unique State Code in accordance with the Indian Census 2011. For instance, the State Code of New Delhi is '07' and that of Karnataka is '29'.
  /// 3. The next 10 characters denote the PAN (Permanent Account Number) of the taxpayer.
  /// 4. The 13th digit denotes the Registration Number (or Entity Number) of the tax payer with the same PAN.
  /// 5. The 14th digit is 'Z' by default for all – not intending anything currently.
  /// 6. The 15th digit is the Check sum digit – can be a number or an alphabetical character.
  ///
  /// see
  /// https://www.geeksforgeeks.org/how-to-validate-gst-goods-and-services-tax-number-using-regular-expression/
  /// https://dba.stackexchange.com/questions/203612/validating-the-gst-identification-number-gstin
  /// https://stackoverflow.com/questions/44431819/regex-for-gst-identification-number-gstin
  factory GSTValidator() {
    _instance ??= GSTValidator._();
    return _instance!;
  }

  GSTValidator._();

  static GSTValidator? _instance;

  /// function to check if the provided [gst] is valid or not.
  ///
  /// returns true if the [dlNumber] seems to be valid.
  bool isValid(String? gst) {
    if (gst == null) return false;

    if (gst.length != 15) {
      // gst number must be 15 characters long
      return false;
    }

    RegExp gstRegEx =
        RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$");
    if (gstRegEx.hasMatch(gst)) {
      // now validate the checksum digit
      return _validCheckSum(gst);
    }

    return false;
  }

  /// validate the checksum of
  bool _validCheckSum(String gstNum) {
    String check = gstNum.substring(gstNum.length - 1);
    String lmo = gstNum.substring(0, 14);

    List<int> l = [], m = [], n = [];
    List<String> gst = lmo.split('');
    for (var i = 0; i < gst.length; ++i) {
      if (RegExp(r'^[0-9]+$').hasMatch(gst[i])) {
        l.add(int.parse(gst[i]));
      } else {
        l.add(lmo.codeUnitAt(i) - 55);
      }
    }
    for (var i = 0; i < l.length; ++i) {
      m.add(l[i] * (i % 2 + 1));
    }
    for (var i = 0; i < m.length; ++i) {
      n.add(((m[i] / 36) + (m[i] % 36)).truncate());
    }

    int sum = n.fold(0, (p, c) => p + c);

    var checkSum = 36 - sum % 36;
    var checkSumDigit = checkSum < 10
        ? checkSum.toString()
        : String.fromCharCode(checkSum + 55);
    return checkSumDigit == check;
  }

  /// format the [gst].
  ///
  /// Basically it will uppercase the number.
  String? format(String? gst) {
    return gst?.toUpperCase();
  }
}
