import 'package:egytimes/bloc/search_cubit/cubit/search_cubit.dart';
import 'package:egytimes/bloc/search_cubit/cubit/search_state.dart';
import 'package:egytimes/presentation/screens/widgets/custom_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
            backgroundColor: Colors.white,
            elevation: 1.6,
            centerTitle: true,
            title: const Text(
              'Times',
              style: TextStyle(
                fontFamily: 'Times',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
              ),
            ),
          ),
          body: Column(
            children: [
              // search bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (value) => {
                    cubit.setSearchedForItem(value),
                    cubit.getSearchNews(),
                    if (kDebugMode)
                      {
                        // ignore: avoid_print
                      }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'What are you looking for?',
                  ),
                ),
              ),
              // search results
              Expanded(
                child: _buildSearchResults(context, cubit),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, var cubit) {
    try {
      if (cubit.searchedForText == '') {
        return const Center(child: CircularProgressIndicator());
      } else {
        return MyCustomListView(cubit: cubit);
      }
    } catch (e) {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
