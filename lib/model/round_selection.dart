import 'dart:convert';

enum SelectionType {
  deer,
  gourd,
  chicken,
  fish,
  crab,
  shrimp;

  factory SelectionType.of(String? s) {
    try {
      return SelectionType.values
          .firstWhere((element) => element.toString() == s);
    } catch (e) {
      return deer;
    }
  }
}

class RoundSelection {
  final int? id;
  final DateTime createdDate;
  final SelectionType selection;
  final int count;
  final int roundId;

  RoundSelection({
    this.id,
    required this.createdDate,
    required this.selection,
    required this.count,
    required this.roundId,
  });

  RoundSelection copyWith({
    int? id,
    DateTime? createdDate,
    SelectionType? selection,
    int? count,
    int? roundId,
  }) {
    return RoundSelection(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      selection: selection ?? this.selection,
      count: count ?? this.count,
      roundId: roundId ?? this.roundId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_date': createdDate.toIso8601String(),
      'selection': selection.toString(),
      'count': count,
      'round_id': roundId,
    };
  }

  factory RoundSelection.fromMap(Map<String, dynamic> map) {
    return RoundSelection(
      id: map['id'] != null ? map['id'] as int : null,
      createdDate: DateTime.tryParse(map['created_date']?.toString() ?? "") ??
          DateTime.now(),
      selection: SelectionType.of(map['selection']),
      count: map['count'] as int,
      roundId: map['round_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoundSelection.fromJson(String source) =>
      RoundSelection.fromMap(json.decode(source) as Map<String, dynamic>);
}
