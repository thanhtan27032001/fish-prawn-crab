import 'package:fish_prawn_crab/db/db_schema.dart';
import 'package:fish_prawn_crab/db/db_service.dart';
import 'package:fish_prawn_crab/model/round.dart';
import 'package:fish_prawn_crab/repository/round/round_repo.dart';
import 'package:fish_prawn_crab/repository/row/round_selection_repo_impl.dart';

class RoundRepoImpl extends RoundRepo {
  final table = DatabaseSchema.tableRound;

  @override
  Future<RoundModel?> createRound() async {
    try {
      final db = DatabaseService.instance.database;
      final id = await db?.insert(
        table.name,
        {
          'created_date': DateTime.now().toIso8601String(),
        },
      );

      if (id != null) {
        final list = await db?.query(
          table.name,
          where: 'id = ?',
          whereArgs: [id],
        );

        if (list != null && list.isNotEmpty) {
          return RoundModel.fromMap(list.first);
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Future<List<RoundModel>> getAllRound() async {
    List<RoundModel> result = [];
    try {
      final db = DatabaseService.instance.database;
      final records = await db?.query(
        table.name,
        orderBy: 'id DESC',
      );

      for (final record in records!) {
        final round = RoundModel.fromMap(record);
        final roundSelections =
            await RoundSelectionRepoImpl().getRoundSelections(round: round);
        result.add(round.copyWith(selections: roundSelections));
      }
    } catch (e) {
      print(e);
    }
    return result;
  }
}
