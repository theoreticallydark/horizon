import 'package:flutter/material.dart';
import '../styles/tokens.dart';

class ButtonGraphicImage extends StatelessWidget {
  /// Component version for reference.
  static const String version = '1.0.1';

  final VoidCallback? onTap;

  const ButtonGraphicImage({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AlterSemanticTokens.ui1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AlterSemanticTokens.stroke200,
            width: 1,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            color: AlterSemanticTokens.ui6,
            size: 24,
          ),
        ),
      ),
    );
  }
}
