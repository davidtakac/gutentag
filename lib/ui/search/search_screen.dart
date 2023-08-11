import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/di/injection.dart';
import 'package:gutentag/domain/sort.dart';
import 'package:gutentag/ui/common/book_card.dart';
import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:gutentag/ui/search/filter_screen.dart';
import 'package:gutentag/ui/search/search_bloc.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  late SearchBloc searchBloc;
  late TextEditingController textController;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    searchBloc = getIt();
    textController = TextEditingController()..text = searchBloc.state.query;
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
          searchBloc.add(LoadMore());
        }
      });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;
    return BlocConsumer<SearchBloc, SearchState>(
      bloc: searchBloc,
      listener: (context, state) {},
      builder: (context, state) {
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
              onSubmitted: (_) => searchBloc.add(Search()),
              onChanged: (query) => searchBloc.add(SetQuery(query)),
            ),
            bottom: PreferredSize(
              preferredSize: const Size(0, 6),
              child: state.status == SearchStatus.loading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink()
            ),
            actions: [
              _SortOptionMenuButton(
                option: state.sortOption,
                onOptionSelected: (Sort option) {
                  searchBloc.add(SetSortOption(option));
                  searchBloc.add(Search());
                },
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return FilterScreen(searchBloc: searchBloc);
                  }));
                },
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
          body: state.results.isEmpty
            ? _Empty(why: state.status, query: state.query)
            : ListView.builder(
                controller: scrollController,
                itemCount: state.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        16,
                        index == 0 ? 16 : 8,
                        16,
                        index == state.results.length - 1 ? 16 : 0),
                    child: BookCard(cardState: state.results[index]),
                  );
                },
              ),
        );
      },
    );
  }
}

class _SortOptionMenuButton extends StatelessWidget {
  final Sort option;
  final Function(Sort) onOptionSelected;

  const _SortOptionMenuButton(
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

class _Empty extends StatelessWidget {
  const _Empty({required this.why, required this.query});

  final SearchStatus why;
  final String query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final String text;
    switch (why) {
      case SearchStatus.empty: text = AppLocalizations.of(context)!.search_no_results(query);
      case SearchStatus.error: text = AppLocalizations.of(context)!.search_error;
      case SearchStatus.idle: text = AppLocalizations.of(context)!.search_idle;
      default: text = "";
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
      ),
    );
  }
}