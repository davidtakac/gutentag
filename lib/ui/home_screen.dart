import 'package:flutter/material.dart';
import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/get_all_books_use_case.dart';
import 'package:gutentag/presentation/all_books_state.dart';
import 'package:gutentag/presentation/all_books_view_model.dart';
import 'package:gutentag/ui/book_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/ui/book_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = AllBooksViewModel(getAllBooksUseCase: GetAllBooksUseCase(apiService: ApiService()))..getNextPage();

  @override
  Widget build(BuildContext context) {
    final listController = ScrollController();
    listController.addListener(() {
      if (listController.position.atEdge && listController.position.pixels != 0) {
        viewModel.getNextPage();
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
            valueListenable: viewModel.books,
            builder: (BuildContext context, List<BookCardState> value, Widget? child) {
              return ListView.builder(
                  controller: listController,
                  itemCount: value.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.fromLTRB(
                      16, 
                      index == 0 ? 16 : 8, 
                      16, 
                      index == value.length - 1 ? 16 : 0
                    ),
                    child: BookCard(cardState: value[index]),
                ),
              ).build(context);
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