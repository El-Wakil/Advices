import 'package:equatable/equatable.dart';

class CatFactModel extends Equatable {
  final String fact;
  final int length;

  const CatFactModel({required this.fact, required this.length});

  factory CatFactModel.fromJson(Map<String, dynamic> json) {
    return CatFactModel(
      fact: json['fact'] as String,
      length: json['length'] as int,
    );
  }

  @override
  List<Object?> get props => [fact, length];
}
