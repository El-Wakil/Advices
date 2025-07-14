import 'package:dio/dio.dart';

import '../../../features/data_models/catfact_model.dart';

class CatFactService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://catfact.ninja';

  Future<CatFactModel> getRandomCatFact() async {
    try {
      final response = await _dio.get('$_baseUrl/fact');
      if (response.statusCode == 200 && response.data != null) {
        return CatFactModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load cat fact');
      }
    } catch (e) {
      throw Exception('Error fetching cat fact: $e');
    }
  }
}
