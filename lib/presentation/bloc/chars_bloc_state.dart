part of 'chars_bloc_bloc.dart';

@immutable
sealed class CharsBlocState {}

final class CharsBlocInitial extends CharsBlocState {}

final class CharsBlocLoading extends CharsBlocState {}

final class CharsBlocSuccess extends CharsBlocState {
  final Character_Model model;
  CharsBlocSuccess({required this.model});
}

final class CharsBlocError extends CharsBlocState {}
