import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/data/models/episode_model.dart';

class GetEpisodeDataRepo{
  final Dio dio;

  GetEpisodeDataRepo({required this.dio});

  get image => null;
  Future<Episode_model> getEpisodeData({required String url})async{
    final Response response = await dio.get("https://rickandmortyapi.com/api/episode",
    );
    return Episode_model.fromJson(response.data);
    
  }
  
}