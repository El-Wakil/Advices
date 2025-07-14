import 'dart:convert';
import 'dart:io'; // Required for HttpClient

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../features/data_models/Quote_model.dart'; // Required for IOHttpClientAdapter

class QuoteService {
  late final Dio _dio; // Make it late final
  final String _baseUrl = 'https://api.quotable.io';

  QuoteService() {
    _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Always accept
      return client;
    };
    print("QUOTE SERVICE: Initialized with SSL bypass (DEVELOPMENT ONLY!).");
  }

  Future<QuoteModel> getRandomQuote() async {
    print(
      "QUOTE SERVICE: getRandomQuote() called. Requesting URL: $_baseUrl/random",
    );
    try {
      final response = await _dio.get<String>('$_baseUrl/random');
      // ... rest of the method remains the same as the previous good version ...
      print("QUOTE SERVICE: Response status: ${response.statusCode}");
      print("QUOTE SERVICE: Response raw string data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data != null && response.data!.isNotEmpty) {
          final Map<String, dynamic> parsedJson = json.decode(response.data!);
          print("QUOTE SERVICE: Parsed JSON data: $parsedJson");
          final responseData = parsedJson;
          if (responseData.isNotEmpty) {
            print("QUOTE SERVICE: Passing parsed JSON to model: $responseData");
            return QuoteModel.fromJson(responseData);
          } else {
            print("QUOTE SERVICE: Error - Parsed JSON data is empty.");
            throw Exception(
              "Invalid data format from Quote API: Parsed JSON is empty.",
            );
          }
        } else {
          print(
            "QUOTE SERVICE: Error - Response data string is null or empty.",
          );
          throw Exception(
            "Received null or empty response string from Quote API.",
          );
        }
      } else {
        print(
          "QUOTE SERVICE: Error - API returned status ${response.statusCode}. Response: ${response.data}",
        );
        throw Exception('Failed to load quote: Status ${response.statusCode}');
      }
    } on DioException catch (e) {
      print("QUOTE SERVICE: DioError caught!");
      print("QUOTE SERVICE: DioError type: ${e.type}");
      print("QUOTE SERVICE: DioError message: ${e.message}");
      print("QUOTE SERVICE: DioError error: ${e.error}");
      print("QUOTE SERVICE: DioError request options: ${e.requestOptions.uri}");
      print("QUOTE SERVICE: DioError response: ${e.response?.data}");
      // print("QUOTE SERVICE: DioError stackTrace: ${e.stackTrace}"); // Can be very verbose

      String detailedErrorMessage = "Network error fetching quote.";
      if (e.message != null && e.message!.isNotEmpty) {
        detailedErrorMessage += " Message: ${e.message}.";
      }
      if (e.error is HandshakeException) {
        // Specifically catch HandshakeException now
        detailedErrorMessage += " SSL Handshake Failed. Error: ${e.error}.";
        if (e.error.toString().contains("CERTIFICATE_VERIFY_FAILED")) {
          detailedErrorMessage +=
              " This is often due to incorrect device date/time or network proxy issues.";
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        detailedErrorMessage += " The connection timed out.";
      } else if (e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError) {
        detailedErrorMessage +=
            " Could not connect to the server. Check internet connection and URL. Error: ${e.error}";
      }
      throw Exception(detailedErrorMessage);
    } catch (e) {
      print("QUOTE SERVICE: Unexpected error - $e");
      if (e is FormatException) {
        print("QUOTE SERVICE: JSON Parsing FormatException: ${e.message}");
        throw Exception('Failed to parse quote data from API: ${e.message}');
      }
      throw Exception('An unexpected error occurred in QuoteService: $e');
    }
  }
}
