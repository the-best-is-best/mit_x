import '../get_utils/get_utils.dart';

extension MitXStringUtils on String {
  bool get isNum => MitXUtils.isNum(this);

  bool get isNumericOnly => MitXUtils.isNumericOnly(this);

  bool get isAlphabetOnly => MitXUtils.isAlphabetOnly(this);

  bool get isBool => MitXUtils.isBool(this);

  bool get isVectorFileName => MitXUtils.isVector(this);

  bool get isImageFileName => MitXUtils.isImage(this);

  bool get isAudioFileName => MitXUtils.isAudio(this);

  bool get isVideoFileName => MitXUtils.isVideo(this);

  bool get isTxtFileName => MitXUtils.isTxt(this);

  bool get isDocumentFileName => MitXUtils.isWord(this);

  bool get isExcelFileName => MitXUtils.isExcel(this);

  bool get isPPTFileName => MitXUtils.isPPT(this);

  bool get isAPKFileName => MitXUtils.isAPK(this);

  bool get isPDFFileName => MitXUtils.isPDF(this);

  bool get isHTMLFileName => MitXUtils.isHTML(this);

  bool get isURL => MitXUtils.isURL(this);

  bool get isEmail => MitXUtils.isEmail(this);

  bool get isPhoneNumber => MitXUtils.isPhoneNumber(this);

  bool get isDateTime => MitXUtils.isDateTime(this);

  bool get isMD5 => MitXUtils.isMD5(this);

  bool get isSHA1 => MitXUtils.isSHA1(this);

  bool get isSHA256 => MitXUtils.isSHA256(this);

  bool get isBinary => MitXUtils.isBinary(this);

  bool get isIPv4 => MitXUtils.isIPv4(this);

  bool get isIPv6 => MitXUtils.isIPv6(this);

  bool get isHexadecimal => MitXUtils.isHexadecimal(this);

  bool get isPalindrom => MitXUtils.isPalindrom(this);

  bool get isPassport => MitXUtils.isPassport(this);

  bool get isCurrency => MitXUtils.isCurrency(this);

  bool get isCpf => MitXUtils.isCpf(this);

  bool get isCnpj => MitXUtils.isCnpj(this);

  bool isCaseInsensitiveContains(String b) =>
      MitXUtils.isCaseInsensitiveContains(this, b);

  bool isCaseInsensitiveContainsAny(String b) =>
      MitXUtils.isCaseInsensitiveContainsAny(this, b);

  String? get capitalize => MitXUtils.capitalize(this);

  String? get capitalizeFirst => MitXUtils.capitalizeFirst(this);

  String get removeAllWhitespace => MitXUtils.removeAllWhitespace(this);

  String? get camelCase => MitXUtils.camelCase(this);

  String? get paramCase => MitXUtils.paramCase(this);

  String numericOnly({bool firstWordOnly = false}) =>
      MitXUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  String createPath([Iterable? segments]) {
    final path = startsWith('/') ? this : '/$this';
    return MitXUtils.createPath(path, segments);
  }
}
