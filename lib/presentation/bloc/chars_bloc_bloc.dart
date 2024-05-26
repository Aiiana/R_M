
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/repositories/get_chars_repo.dart';

part 'chars_bloc_event.dart';
part 'chars_bloc_state.dart';

class CharsBlocBloc extends Bloc<CharsBlocEvent, CharsBlocState> {
  CharsBlocBloc( {required this.repo}) : super(CharsBlocInitial()) {
    on<GetCharsEvent>((event, emit) async{
      try {
        final model= await repo.getData(name:event.name,
        status: event.status,
        gender: event.gender
        );
        emit (CharsBlocSuccess(model: model));
      }catch (e) {
        emit (CharsBlocError());
        
      }
    });
  }
  final GetCharsRepo repo;
}
