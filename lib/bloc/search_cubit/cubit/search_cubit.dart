import 'package:dio/dio.dart';
import 'package:egytimes/bloc/search_cubit/cubit/search_state.dart';
import 'package:egytimes/data/models/articlesModel.dart';
import 'package:egytimes/data/models/postModel.dart';
import 'package:egytimes/shared/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
  var searchedForText = '';
  var baseUrl = 'https://newsapi.org/v2/everything';
  var apiKey = '14edd17012b34b9eaf5117eae583678d';
  var country = 'us';
  var category = 'technology';
  var language = 'en';
  List<Articles>? articles;
  String get getSearchedForText => searchedForText;
  void getSearchNews() {
    try {
      emit(SearchLoading());
      DioHelper.getData(url: baseUrl, query: {
        'apiKey': apiKey,
        'language': language,
        'q': searchedForText,
      }).then((response) async {
        PostModel postModel = PostModel.fromJson(response.data);
        articles = postModel.articles?.map((article) {
          try {
            return Articles(
              title: article.title,
              description: article.description,
              urlToImage: article.urlToImage,
              publishedAt: article.publishedAt,
              url: article.url,
            );
          } catch (e) {
            if (e.runtimeType == DioError) {
              return Articles(
                title: 'Unknown',
                description: ' Problem in API Cannot get description',
                urlToImage: 'assets/images/business-news.png',
                publishedAt: DateTime.now().toString(),
                url: article.url,
              );
            }
          }

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
          print('Successfully fetched Search news');
        }
        emit(SearchLoaded());
      }).catchError(
        (error) {
          if (kDebugMode) {
            print(error);
          }
          emit(SearchError());
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void setSearchedForItem(String searchedForText) {
    this.searchedForText = searchedForText;
  }
}
