import 'package:equatable/equatable.dart';

class QuoteModel extends Equatable {
  final String id;
  final String content;
  final String author;
  final List<String> tags;
  final String authorSlug;
  final int length;
  final String dateAdded;
  final String dateModified;

  const QuoteModel({
    required this.id,
    required this.content,
    required this.author,
    required this.tags,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    print("QUOTE MODEL: fromJson called with data: $json");
    try {
      // Helper to ensure field is a String, else throw FormatException
      String _getString(String key, Map<String, dynamic> map) {
        final value = map[key];
        if (value is String) return value;
        print(
          "QUOTE MODEL: Validation Error - '$key' is not a String. Actual type: ${value?.runtimeType}, value: $value",
        );
        throw FormatException(
          "Invalid type for '$key': Expected String, got ${value?.runtimeType}",
        );
      }

      // Helper to ensure field is an int, else throw FormatException
      int _getInt(String key, Map<String, dynamic> map) {
        final value = map[key];
        if (value is int) return value;
        // Quotable API sometimes returns length as string, try parsing
        if (value is String) {
          final parsedInt = int.tryParse(value);
          if (parsedInt != null) {
            print(
              "QUOTE MODEL: Info - Parsed '$key' from String '$value' to int $parsedInt",
            );
            return parsedInt;
          }
        }
        print(
          "QUOTE MODEL: Validation Error - '$key' is not an int. Actual type: ${value?.runtimeType}, value: $value",
        );
        throw FormatException(
          "Invalid type for '$key': Expected int, got ${value?.runtimeType}",
        );
      }

      // Helper for tags
      List<String> _getStringList(String key, Map<String, dynamic> map) {
        final value = map[key];
        if (value is List) {
          // Ensure all elements are strings, converting if necessary (e.g. from dynamic)
          return value.map((tag) {
            if (tag is String) return tag;
            print(
              "QUOTE MODEL: Info - Tag '$tag' in '$key' is not a String, converting. Actual type: ${tag?.runtimeType}",
            );
            return tag.toString();
          }).toList();
        }
        if (value == null) {
          // Handle case where tags might be null
          print("QUOTE MODEL: Info - '$key' is null, returning empty list.");
          return [];
        }
        print(
          "QUOTE MODEL: Validation Error - '$key' is not a List. Actual type: ${value?.runtimeType}, value: $value",
        );
        throw FormatException(
          "Invalid type for '$key': Expected List, got ${value?.runtimeType}",
        );
      }

      return QuoteModel(
        id: _getString('_id', json),
        content: _getString('content', json),
        author: _getString('author', json),
        tags: _getStringList('tags', json),
        authorSlug: _getString('authorSlug', json),
        length: _getInt('length', json),
        dateAdded: _getString('dateAdded', json),
        dateModified: _getString('dateModified', json),
      );
    } catch (e) {
      print("QUOTE MODEL: Error parsing JSON - $e. Input JSON: $json");
      if (e is FormatException) rethrow;
      throw FormatException(
        "Error parsing QuoteModel from JSON: $e. Input: $json",
      );
    }
  }

  @override
  List<Object?> get props => [
    id,
    content,
    author,
    tags,
    authorSlug,
    length,
    dateAdded,
    dateModified,
  ];

  @override
  String toString() =>
      'QuoteModel(id: $id, author: "$author", content: "$content")';
}
