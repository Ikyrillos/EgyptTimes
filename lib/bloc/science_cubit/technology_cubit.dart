import 'package:egytimes/bloc/science_cubit/technology_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/articlesModel.dart';
import '../../data/models/postModel.dart';
import '../../shared/remote/dio_helper.dart';

class TechnologyCubit extends Cubit<TechnologyState> {
  TechnologyCubit() : super(TechnologyInitial());
  static TechnologyCubit get(BuildContext context) => BlocProvider.of(context);
  var baseUrl = 'https://newsapi.org/v2/top-headlines';
  var apiKey = '14edd17012b34b9eaf5117eae583678d';
  var country = 'eg';
  var category = 'technology';
  var language = 'ar';
  List<Articles>? articles;

  void getScienceNews() {
    try {
      emit(TechnologyNewsLoading());
      DioHelper.getData(url: baseUrl, query: {
        'country': country,
        'category': category,
        'apiKey': apiKey,
        'language': language,
      }).then((response) async {
        PostModel postModel = PostModel.fromJson(response.data);
        articles = postModel.articles?.map((article) {
          return Articles(
            title: article.title,
            description: article.description,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
            url: article.url,
          );
        }).toList();
        if (kDebugMode) {
          print('Sucessfully fetched news');
        }
        emit(TechnologyNewsLoaded());
      }).catchError(
        (error) {
          if (kDebugMode) {
            print(error);
          }
          emit(TechnologyNewsError());
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
