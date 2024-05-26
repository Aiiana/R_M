part of 'chars_bloc_bloc.dart';

@immutable
sealed class CharsBlocEvent {}
class GetCharsEvent extends CharsBlocEvent{
  final String ?name;
  final String?status;
  final String?gender;
  GetCharsEvent({this.name,this.status,this.gender});
}