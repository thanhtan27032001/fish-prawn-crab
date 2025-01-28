import 'package:fish_prawn_crab/model/round.dart';
import 'package:fish_prawn_crab/model/round_selection.dart';

abstract class RoundLogRepo {
  Future<List<RoundSelection>> createRoundLog({
    required RoundModel round,
    required List<RoundSelection> roundSelections,
  });
}
