import 'package:egytimes/data/models/articlesModel.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  List<Articles>? get articles => null;
}

class NewsError extends NewsState {}

class CurrentIndexState extends NewsState {}
