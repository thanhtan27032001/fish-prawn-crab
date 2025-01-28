import 'package:equatable/equatable.dart';
import 'package:fish_prawn_crab/model/round_selection.dart';

class HomeState extends Equatable {
  static const maxRoundSelection = 3;

  final Map<SelectionType, int> selectedMap;

  const HomeState({required this.selectedMap});

  factory HomeState.ds() {
    return const HomeState(
      selectedMap: {},
    );
  }

  int get sumSelectedTime {
    int sumSelectedTime = 0;
    for (final time in selectedMap.values) {
      sumSelectedTime += time;
    }
    return sumSelectedTime;
  }

  bool get canSelectMore {
    return sumSelectedTime < maxRoundSelection;
  }

  bool get canSave {
    return sumSelectedTime == maxRoundSelection;
  }

  @override
  List<Object?> get props => [
        selectedMap,
      ];

  HomeState copyWith({
    Map<SelectionType, int>? selectedMap,
  }) {
    return HomeState(
      selectedMap: selectedMap ?? this.selectedMap,
    );
  }
}
