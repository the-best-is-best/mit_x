## Utils

```dart
import 'package:mit_x/mit_x.dart';

  /// Checks if data is null.
    MitXUtils.isNull(value);

  /// Checks if data is null or blank (empty or only contains whitespace).
  MitXUtils.isNullOrBlank(value);

  /// Checks if data is null or blank (empty or only contains whitespace).
  MitXUtils.isBlank(value);

  /// Checks if string is int or double.
  MitXUtils.isNum(value);

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting "." which double data type have
  MitXUtils.isNumericOnly(value);

  /// Checks if string consist only Alphabet. (No Whitespace)
  MitXUtils.isAlphabetOnly(value);

  /// Checks if string contains at least one Capital Letter
  MitXUtils.hasCapitalletter(value);

  /// Checks if string is boolean.
  MitXUtils.isBool(value);
    
  /// Checks if string is an video file.
  MitXUtils.isVideo(path)

  /// Checks if string is an image file.
  MitXUtils.isImage(path)

  /// Checks if string is an audio file.
  MitXUtils.isAudio(filePath);

  /// Checks if string is an powerpoint file.
  MitXUtils.isPPT( filePath)

  /// Checks if string is an word file.
  MitXUtils.isWord(String filePath)

  /// Checks if string is an excel file.
  MitXUtils.isExcel(String filePath)

  /// Checks if string is an apk file.
  MitXUtils.isAPK(String filePath)

  /// Checks if string is an pdf file.
  MitXUtils.isPDF(String filePath)

  /// Checks if string is an txt file.
  MitXUtils.isTxt(String filePath) 

  /// Checks if string is an chm file.
  MitXUtils.isChm(String filePath)

  /// Checks if string is a vector file.
  MitXUtils.isVector(String filePath)

  /// Checks if string is an html file.
  MitXUtils.isHTML(String filePath

  /// Checks if string is a valid username.
  MitXUtils.isUsername(String s)

  /// Checks if string is URL.
  MitXUtils.isURL(String s) 

  /// Checks if string is email.
  MitXUtils.isEmail(String s)

  /// Checks if string is phone number.
  MitXUtils.isPhoneNumber(String s) 

  /// Checks if string is DateTime (UTC or Iso8601).
  MitXUtils.isDateTime(String s) 

  /// Checks if string is MD5 hash.
  MitXUtils.isMD5(String s) 

  /// Checks if string is SHA1 hash.
  MitXUtils.isSHA1(String s)

  /// Checks if string is SHA256 hash.
  MitXUtils.isSHA256(String s)

  /// Checks if string is SSN (Social Security Number).
  MitXUtils.isSSN(String s) =>

  /// Checks if string is binary.
  MitXUtils.isBinary(String s)
  /// Checks if string is IPv4.

  MitXUtils.isIPv4(String s) 

  /// Checks if string is IPv6.
  MitXUtils.isIPv6(String s)

  /// Checks if string is hexadecimal.
  /// Example: HexColor => #12F
  MitXUtils.isHexadecimal(String s)

  /// Checks if string is Palindrom.
  MitXUtils.isPalindrom(String string)

  /// Checks if all data have same value.
  /// Example: 111111 -> true, wwwww -> true, 1,1,1,1 -> true
  MitXUtils.isOneAKind(dynamic value) 

  /// Checks if string is Passport No.
  MitXUtils.isPassport(String s) 

  /// Checks if string is Currency.
  MitXUtils.isCurrency(String s) 

  /// Checks if length of data is GREATER than maxLength.
  MitXUtils.isLengthGreaterThan(dynamic value, int maxLength)

  /// Checks if length of data is GREATER OR EQUAL to maxLength.
  MitXUtils.isLengthGreaterOrEqual(dynamic value, int maxLength)
  
  /// Checks if length of data is LESS OR EQUAL to maxLength.
  MitXUtils.isLengthLessOrEqual(dynamic value, int maxLength)

  /// Checks if length of data is EQUAL to maxLength.
  MitXUtils.isLengthEqualTo(dynamic value, int otherLength) 

  /// Checks if length of data is BETWEEN minLength to maxLength.
  MitXUtils.isLengthBetween(dynamic value, int minLength, int maxLength) 
  
  /// Checks if a contains b (Treating or interpreting upper- and lowercase
  /// letters as being the same).
  MitXUtils.isCaseInsensitiveContains(String a, String b)

  /// Checks if a contains b or b contains a (Treating or
  /// interpreting upper- and lowercase letters as being the same).
  MitXUtils.isCaseInsensitiveContainsAny(String a, String b)

  /// Checks if num a LOWER than num b.
  MitXUtils.isLowerThan(num a, num b) 

  /// Checks if num a GREATER than num b.
  MitXUtils.isGreaterThan(num a, num b) 

  /// Checks if num a EQUAL than num b.
  MitXUtils.isEqual(num a, num b)

  //Check if num is a cnpj
  MitXUtils.isCnpj(String cnpj)

  /// Checks if the cpf is valid.
  MitXUtils.isCpf(String cpf)
  /// Capitalize each word inside string
  /// Example: your name => Your Name, your name => Your name
  MitXUtils.capitalize(String value) 

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  MitXUtils.capitalizeFirst(String s) 

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  MitXUtils.removeAllWhitespace(String value) 

  /// Camelcase string
  /// Example: your name => yourName
  MitXUtils.camelCase(String value)=
 

  /// snake_case
  MitXUtils.snakeCase(String? text, {String separator = '_'}) 
  /// param-case
  MitXUtils.paramCase(String? text) => snakeCase(text, separator: '-');

  /// Extract numeric value of string
  /// Example: OTP 12312 27/04/2020 => 1231227042020ß
  /// If firstword only is true, then the example return is "12312"
  /// (first found numeric word)
  MitXUtils.numericOnly(String s, {bool firstWordOnly = false})

  MitXUtils.hasMatch(String? value, String pattern)

```