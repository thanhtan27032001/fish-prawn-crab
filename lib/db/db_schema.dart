class DatabaseSchema {
  static final tableRound = DatabaseTable(
    name: "round",
    fields: {
      "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
      "created_date": "DATETIME",
    },
  );

  static final tableRoundLog = DatabaseTable(
    name: "round_log",
    fields: {
      "id": "INTEGER PRIMARY KEY AUTOINCREMENT",
      "created_date": "DATETIME",
      "selection": "TEXT",
      "count": "INTEGER",
      "round_id": "INTEGER REFERENCES round(id)",
    },
  );
}

class DatabaseTable {
  final String name;
  final Map<String, String> fields;

  DatabaseTable({required this.name, required this.fields});
}
