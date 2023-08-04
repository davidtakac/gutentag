import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? getLanguageName(BuildContext context, String languageCode) {
  final l10n = AppLocalizations.of(context)!;
  switch (languageCode) {
    case 'en': return l10n.lang_en;
    case 'tl': return l10n.lang_tl;
    default: return null;
  }
}