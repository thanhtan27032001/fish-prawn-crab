import 'package:fish_prawn_crab/db/db_schema.dart';
import 'package:fish_prawn_crab/db/db_service.dart';
import 'package:fish_prawn_crab/model/round.dart';
import 'package:fish_prawn_crab/repository/round/round_repo.dart';

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
}
