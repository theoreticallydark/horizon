import 'package:flutter/material.dart';
import '../alter/alter.dart';
import '../horizon/horizon_title_bar.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlterSemanticTokens.baseWhite,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: const [
          HorizonTitleBar(
            title: 'Statistics',
            subtitle: 'Overview',
          ),
          HorizonTitleBar(
            title: 'Nutrients',
            subtitle: 'Daily & Weekly Goals',
          ),
          HorizonTitleBar(
            title: 'Routine Adherence',
            subtitle: 'Last 7 Days',
          ),
        ],
      ),
    );
  }
}
