import 'package:flutter/material.dart';
import '../alter/alter.dart';

class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseWhite,
      body: const SafeArea(
        child: Column(
          children: [
            ApplicationHeader(
              title: 'Horizon',
              subtitle: 'Track Nutrition',
              hasActionOne: true,
              hasProfileAction: true,
            ),
          ],
        ),
      ),
    );
  }
}
