import 'package:flutter/material.dart';
import '../alter/alter.dart';

class RoutinePage extends StatelessWidget {
  const RoutinePage({super.key});

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
      child: ListView(
        children: const [
          // Bottom padding offset for bottom navigation bar
          SizedBox(height: 120),
        ],
      ),
    );
  }
}
