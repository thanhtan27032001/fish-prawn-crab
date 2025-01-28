import 'package:fish_prawn_crab/home/logic/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.ds());

  void onBauCuaTypeTap(BauCuaType type) {
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

  void onSave() {
    emit(state.copyWith(selectedMap: {}));
  }

  void onClear() {
    emit(state.copyWith(selectedMap: {}));
  }
}
