import 'package:equatable/equatable.dart';

enum BauCuaType {
  deer,
  gourd,
  chicken,
  fish,
  crab,
  shrimp;
}

class HomeState extends Equatable {
  static const maxRoundSelection = 3;

  final Map<BauCuaType, int> selectedMap;

  const HomeState({required this.selectedMap});

  factory HomeState.ds() {
    return const HomeState(
      selectedMap: {},
    );
  }

  bool get canSelectMore {
    int sumSelectedTime = 0;
    for (final time in selectedMap.values) {
      sumSelectedTime += time;
    }
    return sumSelectedTime < maxRoundSelection;
  }

  @override
  List<Object?> get props => [
        selectedMap,
      ];

  HomeState copyWith({
    Map<BauCuaType, int>? selectedMap,
  }) {
    return HomeState(
      selectedMap: selectedMap ?? this.selectedMap,
    );
  }
}
