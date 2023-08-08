import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';
import 'package:gutentag/ui/common/book_card.dart';
import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:gutentag/ui/search/filter_screen.dart';
import 'package:gutentag/ui/search/search_view_model.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  late SearchViewModel viewModel;
  late TextEditingController textController;
  late ScrollController scrollController;

  @override
  void initState() {
    viewModel = SearchViewModel(
        searchBooksUseCase: SearchUseCase(apiService: ApiService()));
    textController = TextEditingController()..text = viewModel.query;
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          viewModel.loadNextPage();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;
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
          onChanged: (query) => viewModel.query = query,
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
                return FilterScreen(viewModel: viewModel);
              }));
            },
            icon: const Icon(Icons.tune),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: viewModel.results,
          builder: (context, List<BookCardState>? value, child) {
            if (value == null || value.isEmpty) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Text(
                  value == null
                      ? AppLocalizations.of(context)!.search_idle
                      : AppLocalizations.of(context)!.search_no_results(textController.text),
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
                ),
              );
            }

            return ListView.builder(
              controller: scrollController,
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == value.length - 1 ? 16 : 0),
                  child: BookCard(cardState: value[index]),
                );
              },
            );
          }),
    );
  }
}

class SortOptionMenuButton extends StatelessWidget {
  final Sort option;
  final Function(Sort) onOptionSelected;

  const SortOptionMenuButton(
      {required this.option, required this.onOptionSelected, super.key});

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
