import 'package:egytimes/bloc/business_cubit/news_state.dart';
import 'package:egytimes/data/models/articlesModel.dart';
import 'package:egytimes/data/models/postModel.dart';
import 'package:egytimes/shared/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);
  var baseUrl = 'https://newsapi.org/v2/top-headlines';
  var apiKey = '14edd17012b34b9eaf5117eae583678d';
  var country = 'us';
  var category = 'business';
  var language = 'en';
  var currentIndex = 0;
  List<Articles>? articles;

  void getNews() {
    try {
      emit(NewsLoading());
      DioHelper.getData(url: baseUrl, query: {
        'country': country,
        'category': category,
        'apiKey': apiKey,
        'language': language,
      }).then((response) async {
        PostModel postModel = PostModel.fromJson(response.data);
        articles = postModel.articles?.map((article) {
          if (kDebugMode) {
            print(article.title);
          }
          return Articles(
            title: article.title,
            description: article.description,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt,
            url: article.url,
          );
        }).toList();
        if (kDebugMode) {
          print('from cubit: Successfully fetched news');
        }
        emit(NewsLoaded());
      }).catchError(
        (error) {
          if (kDebugMode) {
            print(error);
          }
          emit(NewsError());
        },
      );
    } catch (e) {
      emit(NewsError());
    }
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    emit(CurrentIndexState());
  }
}
