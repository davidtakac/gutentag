import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/search_use_case.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/presentation/search_view_model.dart';
import 'package:gutentag/ui/book_card.dart';
import 'package:gutentag/ui/book_search_filter_screen.dart';

class BookSearchScreen extends StatelessWidget {
  BookSearchScreen({super.key}) {
    textController.text = viewModel.query.value;
  }

  final viewModel = SearchViewModel(searchBooksUseCase: SearchUseCase(apiService: ApiService()));
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;
    final listController = ScrollController();
    listController.addListener(() {
      if (listController.position.atEdge && listController.position.pixels != 0) {
        viewModel.loadNextPage();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textController,
          style: textStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.of(context)!.search_hint,
            hintStyle: textStyle?.copyWith(color: theme.hintColor),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => viewModel.loadNextPage(),
          onChanged: viewModel.setSearchQuery,
        ),
        bottom: PreferredSize(
            preferredSize: const Size(0, 6),
            child: ValueListenableBuilder(
              valueListenable: viewModel.isLoading,
              builder: (BuildContext context, bool isLoading, Widget? child) {
                return isLoading
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink();
              },
            ),
        ),
        actions: [
          ValueListenableBuilder(
              valueListenable: viewModel.sortOption,
              builder: (context, value, child) {
                return SortOptionMenuButton(
                  option: value,
                  onOptionSelected: (Sort option) {
                    viewModel.setSortOption(option);
                    viewModel.loadNextPage();
                  },
                );
              }),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BookSearchFilterScreen(
                  viewModel: viewModel,
                );
              }));
            },
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: viewModel.results,
                builder: (context, value, child) {
                  return ListView(
                    controller: listController,
                    children: value == null || value.isEmpty
                        ? [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                        child: Text(value == null
                            ? AppLocalizations.of(context)!.search_idle
                            : AppLocalizations.of(context)!.search_no_results(textController.text),
                          style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
                        ),
                      )
                    ]
                        : value
                        .asMap()
                        .map((idx, e) => MapEntry(
                      idx,
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              16,
                              idx == 0 ? 16 : 8,
                              16,
                              idx == value.length - 1 ? 16 : 0),
                          child: BookCard(cardState: value[idx])),
                    ))
                        .values
                        .toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class SortOptionMenuButton extends StatelessWidget {
  final Sort option;
  final Function(Sort) onOptionSelected;

  const SortOptionMenuButton({required this.option, required this.onOptionSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Sort>(
      onSelected: onOptionSelected,
      initialValue: option,
      icon: const Icon(Icons.sort),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Sort>>[
        PopupMenuItem<Sort>(
          value: Sort.popular,
          child: Text(AppLocalizations.of(context)!.search_sort_popular),
        ),
        PopupMenuItem<Sort>(
          value: Sort.ascending,
          child: Text(AppLocalizations.of(context)!.search_sort_ascending),
        ),
        PopupMenuItem<Sort>(
          value: Sort.descending,
          child: Text(AppLocalizations.of(context)!.search_sort_descending),
        ),
      ],
    );
  }
}