import 'package:egytimes/bloc/science_cubit/technology_cubit.dart';
import 'package:egytimes/bloc/science_cubit/technology_state.dart';
import 'package:egytimes/presentation/screens/widgets/custom_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class TechnologyNewsScreen extends StatelessWidget {
  const TechnologyNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = TechnologyCubit.get(context);
    return BlocConsumer<TechnologyCubit, TechnologyState>(
        listener: (context, state) {
      if (state is TechnologyNewsLoaded) {
        if (kDebugMode) {
          print('Successfully fetched news');
        }
      } else if (state is TechnologyNewsError) {
        if (kDebugMode) {
          print('Error fetching news');
        }
      }
    }, builder: (context, state) {
      if (state is TechnologyNewsLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orangeAccent,
          ),
        );
      } else if (state is TechnologyNewsLoaded) {
        return MyCustomListView(cubit: cubit);
      } else if (state is TechnologyNewsError) {
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
