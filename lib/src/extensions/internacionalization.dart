import 'dart:ui';

import 'package:mit_x/mit_x.dart';

class _IntlHost {
  Locale? locale;

  Locale? fallbackLocale;

  Map<String, Map<String, String>> translations = {};
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension LocalesIntl on MitXInterface {
  static final _intlHost = _IntlHost();

  Locale? get locale => _intlHost.locale;

  Locale? get fallbackLocale => _intlHost.fallbackLocale;

  set locale(Locale? newLocale) => _intlHost.locale = newLocale;

  set fallbackLocale(Locale? newLocale) => _intlHost.fallbackLocale = newLocale;

  Map<String, Map<String, String>> get translations => _intlHost.translations;

  void addTranslations(Map<String, Map<String, String>> tr) {
    translations.addAll(tr);
  }

  void clearTranslations() {
    translations.clear();
  }

  void appendTranslations(Map<String, Map<String, String>> tr) {
    tr.forEach((key, map) {
      if (translations.containsKey(key)) {
        translations[key]!.addAll(map);
      } else {
        translations[key] = map;
      }
    });
  }
}

extension Trans on String {
  // Checks whether the language code and country code are present, and
  // whether the key is also present.
  bool get _fullLocaleAndKey {
    return MitX.translations.containsKey(
            "${MitX.locale!.languageCode}_${MitX.locale!.countryCode}") &&
        MitX.translations[
                "${MitX.locale!.languageCode}_${MitX.locale!.countryCode}"]!
            .containsKey(this);
  }

  // Checks if there is a callback language in the absence of the specific
  // country, and if it contains that key.
  Map<String, String>? get _getSimilarLanguageTranslation {
    final translationsWithNoCountry = MitX.translations
        .map((key, value) => MapEntry(key.split("_").first, value));
    final containsKey = translationsWithNoCountry
        .containsKey(MitX.locale!.languageCode.split("_").first);

    if (!containsKey) {
      return null;
    }

    return translationsWithNoCountry[
        MitX.locale!.languageCode.split("_").first];
  }

  String get tr {
    // print('language');
    // print(MitX.locale!.languageCode);
    // print('contains');
    // print(MitX.translations.containsKey(MitX.locale!.languageCode));
    // print(MitX.translations.key);
    // Returns the key if locale is null.
    if (MitX.locale?.languageCode == null) return this;

    if (_fullLocaleAndKey) {
      return MitX.translations[
          "${MitX.locale!.languageCode}_${MitX.locale!.countryCode}"]![this]!;
    }
    final similarTranslation = _getSimilarLanguageTranslation;
    if (similarTranslation != null && similarTranslation.containsKey(this)) {
      return similarTranslation[this]!;
      // If there is no corresponding language or corresponding key, return
      // the key.
    } else if (MitX.fallbackLocale != null) {
      final fallback = MitX.fallbackLocale!;
      final key = "${fallback.languageCode}_${fallback.countryCode}";

      if (MitX.translations.containsKey(key) &&
          MitX.translations[key]!.containsKey(this)) {
        return MitX.translations[key]![this]!;
      }
      if (MitX.translations.containsKey(fallback.languageCode) &&
          MitX.translations[fallback.languageCode]!.containsKey(this)) {
        return MitX.translations[fallback.languageCode]![this]!;
      }
      return this;
    } else {
      return this;
    }
  }

  String trArgs([List<String> args = const []]) {
    var key = tr;
    if (args.isNotEmpty) {
      for (final arg in args) {
        key = key.replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }
    return key;
  }

  String trPlural([String? pluralKey, int? i, List<String> args = const []]) {
    return i == 1 ? trArgs(args) : pluralKey!.trArgs(args);
  }

  String trParams([Map<String, String> params = const {}]) {
    var trans = tr;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        trans = trans.replaceAll('@$key', value);
      });
    }
    return trans;
  }

  String trPluralParams(
      [String? pluralKey, int? i, Map<String, String> params = const {}]) {
    return i == 1 ? trParams(params) : pluralKey!.trParams(params);
  }
}
