import 'package:fish_prawn_crab/db/db_schema.dart';
import 'package:fish_prawn_crab/db/db_service.dart';
import 'package:fish_prawn_crab/model/round.dart';
import 'package:fish_prawn_crab/model/round_selection.dart';
import 'package:fish_prawn_crab/repository/row/round_log_repo.dart';

class RoundLogRepoImpl extends RoundLogRepo {
  static final table = DatabaseSchema.tableRoundLog;

  @override
  Future<List<RoundSelection>> createRoundLog({
    required RoundModel round,
    required List<RoundSelection> roundSelections,
  }) async {
    try {
      final db = DatabaseService.instance.database;
      for (final selection in roundSelections) {
        await db?.insert(table.name, selection.toMap());
      }

      final records = await db?.query(
        table.name,
        where: "round_id = ?",
        whereArgs: [round.id],
      );

      if (records != null) {
        return records.map((e) => RoundSelection.fromMap(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
