import 'package:flutter/material.dart';
import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/use_case/search_use_case.dart';
import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:gutentag/ui/search/search_view_model.dart';
import 'package:gutentag/ui/common/book_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/ui/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = SearchViewModel(searchBooksUseCase: SearchUseCase(apiService: ApiService()))..loadNextPage();

  @override
  Widget build(BuildContext context) {
    final listController = ScrollController();
    listController.addListener(() {
      if (listController.position.atEdge && listController.position.pixels != 0) {
        viewModel.loadNextPage();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home_title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder:(context) {
                  return BookSearchScreen();
                },)
              );
            }, 
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: viewModel.results,
            builder: (BuildContext context, List<BookCardState>? value, Widget? child) {
              return ListView(
                  controller: listController,
                  children: [
                    ...value?.map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: BookCard(cardState: e),
                    )).toList() ?? [],
                    const SizedBox(height: 16,)
                  ],
              );
            }
          ),
          Center(
            child: ValueListenableBuilder(
              valueListenable: viewModel.isLoading, 
              builder:(context, value, child) => value ? const CircularProgressIndicator() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}