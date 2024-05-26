
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/data/repositories/get_location_repo.dart';

import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_event.dart';
import 'package:rick_and_morty_app/presentation/bloc/bloc_loc/location_state.dart';


class LocationBlocBloc extends Bloc<LocationBlocEvent, LocationState> {
  final LocationRepository repo;

  LocationBlocBloc({required this.repo}) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final model = await repo.getLocationData(name: event.name);
        if (model.results!.isEmpty) {
          emit(LocationNotFound());
        } else {
          emit(LocationSuccess(locationModel: model));
        }
      } catch (e) {
        emit(LocationError());
      }
    });
  }
}
