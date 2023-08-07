import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/domain/copyright_options.dart';
import 'package:gutentag/presentation/book_search_view_model.dart';
import 'package:gutentag/ui/language_picker_dialog.dart';

class BookSearchFilterScreen extends StatelessWidget {
  BookSearchFilterScreen({required this.viewModel, super.key}) {
    topicController.text = viewModel.topic.value;
  }

  final BookSearchViewModel viewModel;
  final topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        viewModel.search();
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.search_filter_title),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          children: [
            Text(
              AppLocalizations.of(context)!.search_filter_title_copyright,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            ValueListenableBuilder(
                valueListenable: viewModel.copyrightOptions,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      FilterChip(
                          label: Text(AppLocalizations.of(context)!
                              .search_filter_label_copyright_yes),
                          selected:
                              value.any((element) => element == Copyright.yes),
                          onSelected: (_) {
                            viewModel
                              ..toggleCopyrightOption(Copyright.yes)
                              ..search();
                          }),
                      const SizedBox(
                        width: 8,
                      ),
                      FilterChip(
                          label: Text(AppLocalizations.of(context)!
                              .search_filter_label_copyright_no),
                          selected:
                              value.any((element) => element == Copyright.no),
                          onSelected: (_) {
                            viewModel
                              ..toggleCopyrightOption(Copyright.no)
                              ..search();
                          }),
                      const SizedBox(
                        width: 8,
                      ),
                      FilterChip(
                          label: Text(AppLocalizations.of(context)!
                              .search_filter_label_copyright_unknown),
                          selected: value
                              .any((element) => element == Copyright.unknown),
                          onSelected: (_) {
                            viewModel
                              ..toggleCopyrightOption(Copyright.unknown)
                              ..search();
                          })
                    ],
                  );
                }),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppLocalizations.of(context)!.search_filter_title_author,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: viewModel.authorAliveBetween,
                  builder: (context, values, child) {
                    return RangeSlider(
                        min: BookSearchViewModel.authorAliveEarliest.toDouble(),
                        max: BookSearchViewModel.authorAliveLatest.toDouble(),
                        divisions: (BookSearchViewModel.authorAliveLatest -
                                BookSearchViewModel.authorAliveEarliest)
                            .round(),
                        labels: RangeLabels(
                          _formatYear(values.start.round(), context),
                          _formatYear(values.end.round(), context),
                        ),
                        values: values,
                        onChanged: viewModel.setAuthorAliveBetween);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatYear(
                        BookSearchViewModel.authorAliveEarliest, context)),
                    Text(_formatYear(
                        BookSearchViewModel.authorAliveLatest, context)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppLocalizations.of(context)!.search_filter_title_topic,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: topicController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: AppLocalizations.of(context)!.search_filter_hint_topic,
              ),
              onChanged: viewModel.setTopic,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppLocalizations.of(context)!.search_filter_title_languages,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            FilledButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => LanguagePickerDialog(
                      onCancelTap: () {
                        Navigator.of(context).pop();
                      },
                      onSubmit: (codes) {
                        print(codes);
                      },
                    )
                );
              },
              child: Text("TODO")
            ),
          ],
        ),
      ),
    );
  }
}

String _formatYear(int year, BuildContext context) {
  return year < 0
      ? AppLocalizations.of(context)!.search_filter_label_bc(year * -1)
      : AppLocalizations.of(context)!.search_filter_label_ad(year);
}
