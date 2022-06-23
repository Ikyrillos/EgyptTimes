import '../../data/models/articlesModel.dart';

abstract class TechnologyState {}

class TechnologyInitial extends TechnologyState {}

class TechnologyNewsLoading extends TechnologyState {}

class TechnologyNewsLoaded extends TechnologyState {
  List<Articles>? get articles => null;
}

class TechnologyNewsError extends TechnologyState {}
