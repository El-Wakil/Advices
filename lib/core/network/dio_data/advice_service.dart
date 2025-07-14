import 'dart:convert'; // Import for json.decode

import 'package:dio/dio.dart';

import '../../../features/data_models/advice_model.dart';

class AdviceService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.adviceslip.com';

  Future<AdviceModel> getRandomAdvice() async {
    print("ADVICE SERVICE: getRandomAdvice() called");
    try {
      // Explicitly ask Dio to give us the response as a String
      final response = await _dio.get<String>('$_baseUrl/advice');
      print("ADVICE SERVICE: Response status: ${response.statusCode}");
      print("ADVICE SERVICE: Response raw string data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data != null && response.data!.isNotEmpty) {
          // Parse the JSON string into a Map
          final Map<String, dynamic> parsedJson = json.decode(response.data!);
          print("ADVICE SERVICE: Parsed JSON data: $parsedJson");

          final responseData = parsedJson; // Use the parsed map

          if (responseData.containsKey('slip')) {
            final slipData = responseData['slip'] as Map<String, dynamic>?;
            if (slipData != null) {
              print("ADVICE SERVICE: Extracted slipData for model: $slipData");
              return AdviceModel.fromJson(slipData);
            } else {
              print(
                "ADVICE SERVICE: Error - 'slip' object within parsed JSON is null.",
              );
              throw Exception(
                "Invalid data format from Advice API: 'slip' object is null after parsing.",
              );
            }
          } else {
            print(
              "ADVICE SERVICE: Error - Parsed JSON is missing 'slip' key. Full parsed JSON: $responseData",
            );
            throw Exception(
              "Invalid data format from Advice API: Missing 'slip' key in parsed JSON.",
            );
          }
        } else {
          print(
            "ADVICE SERVICE: Error - Response data string is null or empty.",
          );
          throw Exception(
            "Received null or empty response string from Advice API.",
          );
        }
      } else {
        print(
          "ADVICE SERVICE: Error - API returned status ${response.statusCode}. Response: ${response.data}",
        );
        throw Exception('Failed to load advice: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print(
        "ADVICE SERVICE: DioError - ${e.message}. Response: ${e.response?.data}",
      );
      // It's possible e.response?.data is also a string here if the server sends plain text errors
      String errorMessage = e.message ?? "Unknown DioError";
      if (e.response?.data is String) {
        errorMessage += " Server response: ${e.response?.data}";
      }
      throw Exception('Network error fetching advice: $errorMessage');
    } catch (e) {
      print("ADVICE SERVICE: Unexpected error - $e");
      // If it's a FormatException from json.decode, it will be caught here
      if (e is FormatException) {
        print("ADVICE SERVICE: JSON Parsing FormatException: ${e.message}");
        throw Exception('Failed to parse advice data from API: ${e.message}');
      }
      throw Exception('An unexpected error occurred in AdviceService: $e');
    }
  }
}
