import 'package:fish_prawn_crab/model/round_selection.dart';
import 'package:fish_prawn_crab/screen/home/logic/home_bloc.dart';
import 'package:fish_prawn_crab/screen/home/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bau cua log"),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  context.read<HomeBloc>().showBottomSheetAllLogs(context);
                },
                icon: const Icon(Icons.history),
              );
            },
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const padding = 4.0;
    final containerSize = (screenWidth - padding * 2) / 3;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedMap != current.selectedMap,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: padding,
            vertical: padding,
          ),
          child: Column(
            children: [
              Expanded(
                child: Wrap(
                  children: SelectionType.values.map(
                    (e) {
                      return _buildBauCuaSelector(
                        type: e,
                        selectedTime: state.selectedMap[e] ?? 0,
                        size: containerSize,
                        onTap: (type) {
                          context.read<HomeBloc>().onBauCuaTypeTap(type);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              _buildActionButtons(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBauCuaSelector({
    required SelectionType type,
    required int selectedTime,
    required double size,
    required void Function(SelectionType type) onTap,
  }) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          onTap.call(type);
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
            border: selectedTime > 0
                ? Border.all(
                    width: selectedTime * 2,
                    color: Colors.grey,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              "${type.name.toUpperCase()}\n$selectedTime",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  _buildActionButtons(BuildContext context, HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          _buildActionButton(
            context,
            label: "Clear",
            backgroundColor: Colors.red,
            onTap: () {
              context.read<HomeBloc>().onClear();
            },
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            context,
            label: "Save",
            backgroundColor: Colors.green,
            enabled: state.canSave,
            onTap: () {
              context.read<HomeBloc>().onSave();
            },
          ),
        ],
      ),
    );
  }

  _buildActionButton(
    BuildContext context, {
    required String label,
    required void Function() onTap,
    required Color backgroundColor,
    Color labelColor = Colors.white,
    bool enabled = true,
  }) {
    return Expanded(
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(4),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: enabled ? backgroundColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: labelColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
