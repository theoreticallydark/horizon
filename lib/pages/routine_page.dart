import 'package:flutter/material.dart';
import '../alter/alter.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlterSemanticTokens.baseWhite,
      body: const SafeArea(
        child: Column(
          children: [
            ApplicationHeader(
              title: 'Horizon',
              subtitle: 'Daily Routines',
              hasActionOne: true,
              hasProfileAction: true,
            ),
          ],
        ),
      ),
    );
  }
}
