import 'dart:convert';

class RoundModel {
  final int? id;
  final DateTime createdDate;

  RoundModel({required this.id, required this.createdDate});

  RoundModel copyWith({
    int? id,
    DateTime? createdDate,
  }) {
    return RoundModel(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
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
