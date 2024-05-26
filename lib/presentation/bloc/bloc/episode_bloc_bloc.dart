
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/episode_model.dart';
import 'package:rick_and_morty_app/data/repositories/get_episode_data.dart';

part 'episode_bloc_event.dart';
part 'episode_bloc_state.dart';

class EpisodeBlocBloc extends Bloc<EpisodeBlocEvent, EpisodeBlocState> {
  EpisodeBlocBloc({required this.repo}) : super(EpisodeBlocInitial()) {
    on<GetEpisodesEvent>((event, emit) async {
      try {
        emit(
          EpisodeBlocLoading(),
        );
        final episodeModel = await repo.getEpisodeData(
         url : event.url,
        );
        emit(EpisodeBlocSuccess(episodeModel: episodeModel));
      } catch (e) {
        emit(EpisodeBlocError());
      }
    });
  }
  final GetEpisodeDataRepo repo;
}
