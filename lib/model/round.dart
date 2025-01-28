import 'dart:convert';

import 'package:fish_prawn_crab/model/round_selection.dart';

class RoundModel {
  final int? id;
  final DateTime createdDate;
  final List<RoundSelection> selections;

  RoundModel({
    required this.id,
    required this.createdDate,
    this.selections = const [],
  });

  RoundModel copyWith({
    int? id,
    DateTime? createdDate,
    List<RoundSelection>? selections,
  }) {
    return RoundModel(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      selections: selections ?? this.selections,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_date': createdDate.millisecondsSinceEpoch,
    };
  }

  factory RoundModel.fromMap(Map<String, dynamic> map) {
    return RoundModel(
      id: map['id'] != null ? map['id'] as int : null,
      createdDate: DateTime.tryParse(map['created_date']) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoundModel.fromJson(String source) =>
      RoundModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
