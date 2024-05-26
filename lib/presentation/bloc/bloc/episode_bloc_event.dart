part of 'episode_bloc_bloc.dart';

@immutable
sealed class EpisodeBlocEvent {

}
class GetEpisodesEvent extends EpisodeBlocEvent {
  final String url;

  GetEpisodesEvent({required this.url});
}