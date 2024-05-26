import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/location_model.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final LocationModel locationModel;
  
  LocationSuccess({required this.locationModel});
}

class LocationNotFound extends LocationState {}

class LocationError extends LocationState {}
