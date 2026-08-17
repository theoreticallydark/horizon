import 'package:flutter/material.dart';
import '../alter/alter.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseWhite,
      body: const SafeArea(
        child: Column(
          children: [
            ApplicationHeader(
              title: 'Horizon',
              subtitle: 'Stats & Overview',
              hasActionOne: true,
              hasProfileAction: true,
            ),
          ],
        ),
      ),
    );
  }
}
