import 'package:egytimes/bloc/business_cubit/news_cubit.dart';
import 'package:egytimes/bloc/business_cubit/news_state.dart';
import 'package:egytimes/presentation/screens/business.news.screen.dart';
import 'package:egytimes/presentation/screens/search_screen.dart';
import 'package:egytimes/presentation/screens/sports.news.screen.dart';
import 'package:egytimes/presentation/screens/technology.news.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> screens = [
    const BusinessNewsScreen(),
    const SportsNewsScreen(),
    const TechnologyNewsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(context: context),
                  ),
                ),
              },
            ),
          ],
        ),
        body: screens[NewsCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => {NewsCubit.get(context).setCurrentIndex(value)},
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_soccer),
              label: 'Sports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              label: 'Technology',
            ),
          ],
          currentIndex: NewsCubit.get(context).currentIndex,
          selectedItemColor: Colors.black,
        ),
      ),
    );
  }
}
