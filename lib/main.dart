import 'package:egytimes/bloc/business_cubit/news_cubit.dart';
import 'package:egytimes/bloc/science_cubit/technology_cubit.dart';
import 'package:egytimes/bloc/search_cubit/cubit/search_cubit.dart';
import 'package:egytimes/bloc/sports_cubit/sports_cubit.dart';
import 'package:egytimes/presentation/screens/main_screen.dart';
import 'package:egytimes/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => NewsCubit()..getNews()),
        ),
        BlocProvider(
          create: ((context) => SportCubit()..getSportsNews()),
        ),
        BlocProvider(
          create: ((context) => TechnologyCubit()..getScienceNews()),
        ),
        BlocProvider(
          create: ((context) => SearchCubit()),
        ),
      ],
      child: MaterialApp(
        title: 'Times',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
      ),
    );
  }
}
