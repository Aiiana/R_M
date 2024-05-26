part of 'episode_bloc_bloc.dart';

@immutable
sealed class EpisodeBlocState {}

final class EpisodeBlocInitial extends EpisodeBlocState {}

final class EpisodeBlocLoading extends EpisodeBlocState {}  

final class EpisodeBlocSuccess extends EpisodeBlocState {
  final Episode_model episodeModel; 

  EpisodeBlocSuccess(  {required this.episodeModel});
}

final class EpisodeBlocError extends EpisodeBlocState {}
