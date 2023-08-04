// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(query) => "No results for \"${query}\". Try something else.";

  static String m1(translators) => "Translators: ${translators}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "book_btn_download_epub":
            MessageLookupByLibrary.simpleMessage("Download EPUB"),
        "book_btn_download_kindle":
            MessageLookupByLibrary.simpleMessage("Download MOBI"),
        "book_btn_download_txt":
            MessageLookupByLibrary.simpleMessage("Download TXT"),
        "book_btn_read_online":
            MessageLookupByLibrary.simpleMessage("Read Online"),
        "book_title": MessageLookupByLibrary.simpleMessage("Book details"),
        "home_title":
            MessageLookupByLibrary.simpleMessage("Most popular books"),
        "lang_en": MessageLookupByLibrary.simpleMessage("English"),
        "lang_tl": MessageLookupByLibrary.simpleMessage("Tagalog"),
        "search_filter_label_copyright_no":
            MessageLookupByLibrary.simpleMessage("No"),
        "search_filter_label_copyright_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "search_filter_label_copyright_yes":
            MessageLookupByLibrary.simpleMessage("Yes"),
        "search_filter_title":
            MessageLookupByLibrary.simpleMessage("Filter book results"),
        "search_filter_title_copyright":
            MessageLookupByLibrary.simpleMessage("Copyright"),
        "search_hint": MessageLookupByLibrary.simpleMessage("Search"),
        "search_idle": MessageLookupByLibrary.simpleMessage(
            "Try searching for \'Dracula\', I hear it\'s quite good."),
        "search_no_results": m0,
        "search_sort_ascending": MessageLookupByLibrary.simpleMessage("Z-A"),
        "search_sort_descending": MessageLookupByLibrary.simpleMessage("A-Z"),
        "search_sort_popular":
            MessageLookupByLibrary.simpleMessage("Popularity"),
        "translators_none":
            MessageLookupByLibrary.simpleMessage("Original language"),
        "translators_template": m1
      };
}
