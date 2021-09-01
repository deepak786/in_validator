/// validate the AADHAAR number.
///
/// 1. It should have 12 digits.
/// 2. It should not start with 0 and 1.
/// 3. It should not contain any alphabet and special characters.
/// 4. It should be valid with Verhoeff algorithm (https://en.wikipedia.org/wiki/Verhoeff_algorithm)
///
/// The first 11 digits of the 12 digit Aadhaar number displayed on your Aadhaar card is the actual UID Number and
/// the 12th digit is the checksum associated with Verhoeff Algorithm scheme.
class AadhaarValidator {
  /// function to check if the provider [aadhaar] is valid or not.
  ///
  /// return true if the [aadhaar] seems to be valid.
  bool isValid(String? aadhaar) {
    if (aadhaar == null) return false;

    // remove the spaces from aadhaar
    String aadhaarWithoutSpace = aadhaar.replaceAll(RegExp(r"\s+"), "");

    if (aadhaarWithoutSpace.length != 12) {
      // aadhaar length must be 12
      return false;
    }

    RegExp aadhaarRegEx = RegExp(r'[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}');
    if (!aadhaarRegEx.hasMatch(aadhaarWithoutSpace)) {
      // aadhaar regular expression not matched
      return false;
    }

    // now validate with Verhoeff algorithm
    return VerhoeffAlgorithm.validateVerhoeff(aadhaarWithoutSpace);
  }

  /// AADHAAR format is 9999 9999 9999
  ///
  /// So add space after every 4 digits.
  String? format(String? aadhaar) {
    return aadhaar
        ?.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")
        .trim();
  }
}

class VerhoeffAlgorithm {
  // d(j,k)
  //This table is based on multiplication in the dihedral group D5
  // and is simply the Cayley table of the group.
  // Note that this group is not commutative,
  // that is, for some values of j and k, d(j,k) != d(k, j).
  static const _d = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
    [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
    [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
    [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
    [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
    [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
    [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
    [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
    [9, 8, 7, 6, 5, 4, 3, 2, 1, 0],
  ];

  // inv(j)
  // The inverse table inv represents the multiplicative inverse of a digit,
  // that is, the value that satisfies d(j, inv(j)) = 0.
  static const _inv = [
    0,
    4,
    3,
    2,
    1,
    5,
    6,
    7,
    8,
    9,
  ];

  // p(pos,num)
  // The permutation table p applies a permutation to each digit based
  // on its position in the number.
  // This is actually a single permutation (1 5 8 9 4 2 7 0)(3 6)
  // applied iteratively; i.e. p(i+j,n) = p(i, p(j,n)).
  static const _p = [
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
    [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
    [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
    [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
    [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
    [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
    [7, 0, 4, 6, 9, 1, 3, 2, 5, 8],
  ];

  static bool validateVerhoeff(String num) {
    int c = 0;
    List<int> myArray = _stringToReversedIntArray(num);
    for (int i = 0; i < myArray.length; i++) {
      c = _d[c][_p[(i % 8)][myArray[i]]];
    }

    return (c == 0);
  }

  static List<int> _stringToReversedIntArray(String num) {
    List<int> myArray = [];
    for (int i = 0; i < num.length; i++) {
      myArray.add(int.parse(num.substring(i, i + 1)));
    }
    return myArray.reversed.toList();
  }
}
