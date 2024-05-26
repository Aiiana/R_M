

import 'package:flutter/material.dart';

@immutable
sealed class LocationBlocEvent {}

class GetLocationEvent extends LocationBlocEvent {
  final String? name;
  
  GetLocationEvent({this.name, required String url});
}