enum SelectionType {
  deer,
  gourd,
  chicken,
  fish,
  crab,
  shrimp;
}

class RoundLog {
  final int? id;
  final DateTime createdDate;
  final SelectionType selection;
  final int count;
  final int roundId;

  RoundLog({
    required this.id,
    required this.createdDate,
    required this.selection,
    required this.count,
    required this.roundId,
  });

  RoundLog copyWith({
    int? id,
    DateTime? createdDate,
    SelectionType? selection,
    int? count,
    int? roundId,
  }) {
    return RoundLog(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      selection: selection ?? this.selection,
      count: count ?? this.count,
      roundId: roundId ?? this.roundId,
    );
  }
}
