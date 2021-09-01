/// validate the PAN.
///
/// According the WIKI https://en.wikipedia.org/wiki/Permanent_account_number
///
/// The PAN (or PAN number) is a ten-character long alpha-numeric unique identifier.
///
/// The PAN structure is as follows: Fourth character [P — Individual or Person ] Example: AAAPZ1234C
///
/// The first five characters are letters (in uppercase by default), followed by four numerals, and the last (tenth) character is a letter.
/// The first three characters of the code are three letters forming a sequence of alphabets letters from AAA to ZZZ
/// The fourth character identifies the type of holder of the card. Each holder type is uniquely defined by a letter from the list below:
/// A — Association of persons (AOP)
/// B — Body of individuals (BOI)
/// C — Company
/// F — Firm
/// G — Government
/// H — HUF (Hindu undivided family)
/// L — Local authority
/// J — Artificial juridical person
/// P — Person (Individual)
/// T — Trust (AOP)
/// The fifth character of the PAN is the first character of either:
/// of the surname or last name of the person, in the case of a "personal" PAN card, where the fourth character is "P" or
/// of the name of the entity, trust, society, or organisation in the case of a company/HUF/firm/AOP/trust/BOI/local authority/artificial judicial person/government, where the fourth character is "C", "H", "F", "A", "T", "B", "L", "J", "G".
/// The last (tenth) character is an alphabetic digit used as a check-sum to verify the validity of that current code.
class PANValidator {
  /// function to check if the PAN has valid format or not.
  ///
  /// returns true if the PAN has valid format.
  bool isValid(String? pan) {
    if (pan == null || pan.length != 10) {
      // PAN length is not 10
      return false;
    }

    RegExp panRegEx = RegExp(r'[A-Za-z]{5}[0-9]{4}[A-Za-z]{1}');
    return panRegEx.hasMatch(pan);
  }

  /// PAN has all the letters in uppercase.
  /// So this function will return the provided PAN by making each letter as uppercase.
  ///
  /// e.g: aaaaa9999a to AAAAA9999A
  String? format(String? pan) {
    return pan?.toUpperCase();
  }
}
