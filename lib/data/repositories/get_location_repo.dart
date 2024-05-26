import 'package:dio/dio.dart';

import 'package:rick_and_morty_app/data/models/location_model.dart';

class LocationRepository {
  final Dio dio;

  LocationRepository({required this.dio});

  Future<LocationModel> getLocationData({String? name}) async {
    final Response response = await dio.get("https://rickandmortyapi.com/api/location");
    return LocationModel.fromJson(response.data);
  }
}
