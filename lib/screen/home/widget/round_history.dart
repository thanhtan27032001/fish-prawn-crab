import 'package:fish_prawn_crab/model/round.dart';
import 'package:flutter/material.dart';

class RoundHistoryWidget extends StatelessWidget {
  final List<RoundModel> allRound;

  const RoundHistoryWidget({
    super.key,
    required this.allRound,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: allRound.length,
        itemBuilder: (context, index) {
          final round = allRound[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  round.createdDate.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                ...round.selections.map(
                  (e) {
                    return Text("${e.selection.name}: ${e.count}");
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
          );
        },
      ),
    );
  }
}
