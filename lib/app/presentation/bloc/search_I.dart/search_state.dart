import 'package:flutter/cupertino.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<dynamic> results; // Asegúrate de tener este parámetro aquí

  SearchSuccess({required this.results});
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure(this.error);
}
