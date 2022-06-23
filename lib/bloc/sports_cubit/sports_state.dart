import '../../data/models/articlesModel.dart';

abstract class SportsState {}

class SportsInitial extends SportsState {}

class SportsNewsLoading extends SportsState {}

class SportsNewsLoaded extends SportsState {
  List<Articles>? get articles => null;
}

class SportsNewsError extends SportsState {}
