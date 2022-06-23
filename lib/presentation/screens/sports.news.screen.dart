import 'package:egytimes/bloc/sports_cubit/sports_cubit.dart';
import 'package:egytimes/bloc/sports_cubit/sports_state.dart';
import 'package:egytimes/presentation/screens/widgets/custom_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SportsNewsScreen extends StatelessWidget {
  const SportsNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = SportCubit.get(context);
    return BlocConsumer<SportCubit, SportsState>(listener: (context, state) {
      if (state is SportsNewsLoaded) {
        if (kDebugMode) {
          print('Successfully fetched news');
        }
      } else if (state is SportsNewsError) {
        if (kDebugMode) {
          print('Error fetching news');
        }
      }
    }, builder: (context, state) {
      if (state is SportsNewsLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orangeAccent,
          ),
        );
      } else if (state is SportsNewsLoaded) {
        return MyCustomListView(cubit: cubit);
      } else if (state is SportsNewsError) {
        return const Center(
          child: Text('Error fetching news'),
        );
      }
      return const Center(
        child: Text('Loading news'),
      );
    });
  }
}
