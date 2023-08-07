import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/ui/search/search_view_model.dart';
import 'package:gutentag/ui/search/language_picker_dialog.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({required this.viewModel, super.key}) {
    topicController.text = viewModel.topic.value;
  }

  final SearchViewModel viewModel;
  final topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        viewModel.loadNextPage();
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
                              ..loadNextPage();
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
                              ..loadNextPage();
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
                              ..loadNextPage();
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
                        min: SearchViewModel.writtenStartMin.toDouble(),
                        max: SearchViewModel.writtenEndMax.toDouble(),
                        divisions: (SearchViewModel.writtenEndMax -
                                SearchViewModel.writtenStartMin)
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
                        SearchViewModel.writtenStartMin, context)),
                    Text(_formatYear(
                        SearchViewModel.writtenEndMax, context)),
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
            ValueListenableBuilder(
                valueListenable: viewModel.languages,
                builder: (context, value, child) {
                  return Wrap(
                    spacing: 8,
                    children: [
                      ...value.isEmpty
                        ? [const FilterChip(label: Text('All'), selected: true, onSelected: null,)]
                        : value.map((e) => FilterChip(
                            label: Text(e.name),
                            selected: true,
                            onSelected: (_) => viewModel.toggleLanguage(e),
                          )).toList(),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => LanguagePickerDialog(
                                  preselectedLanguages: value,
                                  onCancelTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  onSubmit: (languageCodes) {
                                    viewModel.setLanguages(languageCodes);
                                    Navigator.of(context).pop();
                                  },
                                )
                            );
                          },
                          icon: const Icon(Icons.edit)
                      )
                    ],
                  );
                }
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