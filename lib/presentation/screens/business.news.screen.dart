import 'package:egytimes/bloc/business_cubit/news_cubit.dart';
import 'package:egytimes/bloc/business_cubit/news_state.dart';
import 'package:egytimes/presentation/screens/widgets/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class BusinessNewsScreen extends StatelessWidget {
  const BusinessNewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          } else if (state is NewsLoaded) {
            return MyCustomListView(cubit: cubit);
          } else if (state is NewsError) {
            return const Center(
              child: Text('Error fetching news'),
            );
          }
          return MyCustomListView(cubit: cubit);
        });
  }
}
