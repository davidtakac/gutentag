import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/domain/language.dart';

class LanguagePickerDialog extends StatefulWidget {
  final VoidCallback onCancelTap;
  final Function(List<Language>) onSubmit;
  final List<Language> preselectedLanguages;

  const LanguagePickerDialog({
    required this.onCancelTap,
    required this.onSubmit,
    this.preselectedLanguages = const [],
    super.key
  });

  @override
  State<LanguagePickerDialog> createState() => _LanguagePickerDialogState();
}

class _LanguagePickerDialogState extends State<LanguagePickerDialog> {
  final List<Language> selectedLanguages = [];

  @override
  void initState() {
    selectedLanguages.addAll(widget.preselectedLanguages);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      title: Text(AppLocalizations.of(context)!.search_filter_title_languages),
      content: SingleChildScrollView(
        child: ListBody(
          children: allLanguages.map((e) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (selectedLanguages.contains(e)) {
                    selectedLanguages.remove(e);
                  } else {
                    selectedLanguages.add(e);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: selectedLanguages.contains(e),
                      onChanged: (_) { /* no-op, handled in list tile click */ },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              e.code,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ),
      actions: [
        TextButton(
            onPressed: widget.onCancelTap,
            child: Text(AppLocalizations.of(context)!.search_filter_btn_languages_cancel)
        ),
        TextButton(
            onPressed: () => widget.onSubmit(selectedLanguages),
            child: Text(AppLocalizations.of(context)!.search_filter_btn_languages_ok),
        ),
      ],
    );
  }
}