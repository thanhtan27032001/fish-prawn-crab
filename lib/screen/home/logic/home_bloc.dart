import 'package:fish_prawn_crab/model/round_selection.dart';
import 'package:fish_prawn_crab/repository/round/round_repo_impl.dart';
import 'package:fish_prawn_crab/repository/row/round_log_repo_impl.dart';
import 'package:fish_prawn_crab/screen/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.ds());

  void onBauCuaTypeTap(SelectionType type) {
    final currentSelectedTime = state.selectedMap[type] ?? 0;
    if (state.canSelectMore) {
      emit(
        state.copyWith(
          selectedMap: {
            ...state.selectedMap,
            type: currentSelectedTime + 1,
          },
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedMap: {
            ...state.selectedMap,
            type: 0,
          },
        ),
      );
    }
  }

  Future<void> onSave() async {
    if (!state.canSave) return;
    final round = await RoundRepoImpl().createRound();
    if (round == null) return;

    List<RoundSelection> selections = [];
    for (final selection in state.selectedMap.keys) {
      if ((state.selectedMap[selection] ?? 0) > 0) {
        selections.add(
          RoundSelection(
            createdDate: DateTime.now(),
            selection: selection,
            count: state.selectedMap[selection] ?? 0,
            roundId: round.id ?? 0,
          ),
        );
      }
    }

    final result = await RoundLogRepoImpl().createRoundLog(
      round: round,
      roundSelections: selections,
    );

    emit(state.copyWith(selectedMap: {}));
  }

  void onClear() {
    emit(state.copyWith(selectedMap: {}));
  }
}
