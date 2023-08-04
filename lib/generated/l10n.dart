// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Most popular books`
  String get home_title {
    return Intl.message(
      'Most popular books',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lang_en {
    return Intl.message(
      'English',
      name: 'lang_en',
      desc: '',
      args: [],
    );
  }

  /// `Tagalog`
  String get lang_tl {
    return Intl.message(
      'Tagalog',
      name: 'lang_tl',
      desc: '',
      args: [],
    );
  }

  /// `Book details`
  String get book_title {
    return Intl.message(
      'Book details',
      name: 'book_title',
      desc: '',
      args: [],
    );
  }

  /// `Translators: {translators}`
  String translators_template(Object translators) {
    return Intl.message(
      'Translators: $translators',
      name: 'translators_template',
      desc: '',
      args: [translators],
    );
  }

  /// `Original language`
  String get translators_none {
    return Intl.message(
      'Original language',
      name: 'translators_none',
      desc: '',
      args: [],
    );
  }

  /// `Read Online`
  String get book_btn_read_online {
    return Intl.message(
      'Read Online',
      name: 'book_btn_read_online',
      desc: '',
      args: [],
    );
  }

  /// `Download EPUB`
  String get book_btn_download_epub {
    return Intl.message(
      'Download EPUB',
      name: 'book_btn_download_epub',
      desc: '',
      args: [],
    );
  }

  /// `Download MOBI`
  String get book_btn_download_kindle {
    return Intl.message(
      'Download MOBI',
      name: 'book_btn_download_kindle',
      desc: '',
      args: [],
    );
  }

  /// `Download TXT`
  String get book_btn_download_txt {
    return Intl.message(
      'Download TXT',
      name: 'book_btn_download_txt',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_hint {
    return Intl.message(
      'Search',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Popularity`
  String get search_sort_popular {
    return Intl.message(
      'Popularity',
      name: 'search_sort_popular',
      desc: '',
      args: [],
    );
  }

  /// `Z-A`
  String get search_sort_ascending {
    return Intl.message(
      'Z-A',
      name: 'search_sort_ascending',
      desc: '',
      args: [],
    );
  }

  /// `A-Z`
  String get search_sort_descending {
    return Intl.message(
      'A-Z',
      name: 'search_sort_descending',
      desc: '',
      args: [],
    );
  }

  /// `Try searching for 'Dracula', I hear it's quite good.`
  String get search_idle {
    return Intl.message(
      'Try searching for \'Dracula\', I hear it\'s quite good.',
      name: 'search_idle',
      desc: '',
      args: [],
    );
  }

  /// `No results for "{query}". Try something else.`
  String search_no_results(Object query) {
    return Intl.message(
      'No results for "$query". Try something else.',
      name: 'search_no_results',
      desc: '',
      args: [query],
    );
  }

  /// `Filter book results`
  String get search_filter_title {
    return Intl.message(
      'Filter book results',
      name: 'search_filter_title',
      desc: '',
      args: [],
    );
  }

  /// `Copyright`
  String get search_filter_title_copyright {
    return Intl.message(
      'Copyright',
      name: 'search_filter_title_copyright',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get search_filter_label_copyright_yes {
    return Intl.message(
      'Yes',
      name: 'search_filter_label_copyright_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get search_filter_label_copyright_no {
    return Intl.message(
      'No',
      name: 'search_filter_label_copyright_no',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get search_filter_label_copyright_unknown {
    return Intl.message(
      'Unknown',
      name: 'search_filter_label_copyright_unknown',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
