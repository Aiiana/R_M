import 'package:dio/dio.dart';

import 'package:rick_and_morty_app/data/models/character_model.dart';

class GetCharsRepo {
 
  
     final Dio dio;
      GetCharsRepo({required this.dio,}); 
     Future<Character_Model> getData({String ?name,String?status,String?gender} )async{
      final Response response = await dio.get("https://rickandmortyapi.com/api/character",
      queryParameters: {
        "name": name,
        "status": status,
        "gender": gender
      });
      return Character_Model.fromJson(response.data);
     }
   
  }
