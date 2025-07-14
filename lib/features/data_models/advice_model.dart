import 'package:equatable/equatable.dart';

class AdviceModel extends Equatable {
  final int id;
  final String advice;

  const AdviceModel({required this.id, required this.advice});

  factory AdviceModel.fromJson(Map<String, dynamic> json) {
    print("ADVICE MODEL: fromJson called with data: $json");
    try {
      final id = json['id'];
      final advice = json['advice'];

      if (id is! int) {
        print(
          "ADVICE MODEL: Validation Error - 'id' is not an int. Actual type: ${id?.runtimeType}, value: $id",
        );
        throw FormatException(
          "Invalid type for 'id': Expected int, got ${id?.runtimeType}",
        );
      }
      if (advice is! String) {
        print(
          "ADVICE MODEL: Validation Error - 'advice' is not a String. Actual type: ${advice?.runtimeType}, value: $advice",
        );
        throw FormatException(
          "Invalid type for 'advice': Expected String, got ${advice?.runtimeType}",
        );
      }

      return AdviceModel(id: id, advice: advice);
    } catch (e) {
      print("ADVICE MODEL: Error parsing JSON - $e. Input JSON: $json");
      // Re-throw as a more specific exception if not already a FormatException
      if (e is FormatException) rethrow;
      throw FormatException(
        "Error parsing AdviceModel from JSON: $e. Input: $json",
      );
    }
  }

  @override
  List<Object?> get props => [id, advice];

  @override
  String toString() => 'AdviceModel(id: $id, advice: "$advice")';
}
