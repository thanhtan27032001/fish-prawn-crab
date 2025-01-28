import 'package:fish_prawn_crab/model/round.dart';

abstract class RoundRepo {
  Future<RoundModel?> createRound();

  Future<List<RoundModel>> getAllRound();
}
