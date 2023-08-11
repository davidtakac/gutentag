import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/domain/copyright.dart';
import 'package:gutentag/ui/search/language_picker_dialog.dart';
import 'package:gutentag/ui/search/search_bloc.dart';

class FilterScreen extends StatefulWidget {
  final SearchBloc searchBloc;

  const FilterScreen({super.key, required this.searchBloc});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late TextEditingController topicController;

  @override
  void initState() {
    super.initState();
    topicController = TextEditingController()
      ..text = widget.searchBloc.state.topic;
  }

  @override
  void dispose() {
    topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: widget.searchBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            widget.searchBloc.add(Search());
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
                _SectionHeader(
                  title: AppLocalizations.of(context)!
                      .search_filter_title_copyright,
                ),
                Row(
                  children: [
                    FilterChip(
                        label: Text(AppLocalizations.of(context)!
                            .search_filter_label_copyright_yes),
                        selected: state.copyrightOptions
                            .any((element) => element == Copyright.yes),
                        onSelected: (_) {
                          widget.searchBloc
                              .add(const ToggleCopyrightOption(Copyright.yes));
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    FilterChip(
                        label: Text(AppLocalizations.of(context)!
                            .search_filter_label_copyright_no),
                        selected: state.copyrightOptions
                            .any((element) => element == Copyright.no),
                        onSelected: (_) {
                          widget.searchBloc
                              .add(const ToggleCopyrightOption(Copyright.no));
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    FilterChip(
                        label: Text(AppLocalizations.of(context)!
                            .search_filter_label_copyright_unknown),
                        selected: state.copyrightOptions
                            .any((element) => element == Copyright.unknown),
                        onSelected: (_) {
                          widget.searchBloc.add(
                              const ToggleCopyrightOption(Copyright.unknown));
                        })
                  ],
                ),
                _SectionHeader(
                  title:
                      AppLocalizations.of(context)!.search_filter_title_author,
                ),
                Column(
                  children: [
                    RangeSlider(
                        min: -3500,
                        max: 2023,
                        divisions: 2023 + 3500,
                        labels: RangeLabels(
                          _formatYear(state.writtenStart, context),
                          _formatYear(state.writtenEnd, context),
                        ),
                        values: RangeValues(state.writtenStart.toDouble(),
                            state.writtenEnd.toDouble()),
                        onChanged: (newValues) {
                          widget.searchBloc.add(SetWrittenBetween(
                              newValues.start.round(), newValues.end.round()));
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatYear(-3500, context)),
                        Text(_formatYear(2023, context)),
                      ],
                    )
                  ],
                ),
                _SectionHeader(
                  title:
                      AppLocalizations.of(context)!.search_filter_title_topic,
                ),
                TextField(
                  controller: topicController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText:
                        AppLocalizations.of(context)!.search_filter_hint_topic,
                  ),
                  onChanged: (topic) => widget.searchBloc.add(SetTopic(topic)),
                ),
                _SectionHeader(
                    title: AppLocalizations.of(context)!
                        .search_filter_title_languages),
                Wrap(
                  spacing: 8,
                  children: [
                    ...state.languages.isEmpty
                        ? [
                            FilterChip(
                              label: Text(AppLocalizations.of(context)!
                                  .search_filter_label_languages_all),
                              selected: true,
                              onSelected: null,
                            )
                          ]
                        : state.languages.map((lang) {
                            return FilterChip(
                              label: Text(lang.name),
                              selected: true,
                              onSelected: (_) =>
                                  widget.searchBloc.add(ToggleLanguage(lang)),
                            );
                          }).toList(),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return LanguagePickerDialog(
                                  preselectedLanguages: state.languages,
                                  onCancelTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  onSubmit: (languages) {
                                    widget.searchBloc.add(SetLanguages(languages));
                                    Navigator.of(context).pop();
                                  },
                                );
                              });
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

String _formatYear(int year, BuildContext context) {
  return year < 0
      ? AppLocalizations.of(context)!.search_filter_label_bc(year * -1)
      : AppLocalizations.of(context)!.search_filter_label_ad(year);
}
